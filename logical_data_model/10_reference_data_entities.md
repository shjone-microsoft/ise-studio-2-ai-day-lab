# Reference Data Entities - Logical Data Model

## Overview
This document defines the logical structure for reference data tables, lookup values, and master data management for the Dynamic Supplier Diversification & Risk Scoring System.

---

## Entity: Currency

### Purpose
Master currency reference data with exchange rates and regional usage for financial calculations and reporting.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| CurrencyCode | VARCHAR(3) | PK, NOT NULL | ISO 4217 currency code |
| CurrencyName | VARCHAR(100) | NOT NULL | Currency full name |
| CurrencySymbol | VARCHAR(10) | NOT NULL | Currency symbol |
| CurrencyNumericCode | VARCHAR(3) | UK, NOT NULL | ISO numeric code |
| MinorUnit | INT | NOT NULL, DEFAULT 2, CHECK BETWEEN 0 AND 4 | Decimal places |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active currency flag |
| IsBaseCurrency | BOOLEAN | NOT NULL, DEFAULT FALSE | Base currency flag |
| IsCryptocurrency | BOOLEAN | NOT NULL, DEFAULT FALSE | Cryptocurrency flag |
| CountryCode | VARCHAR(2) | FK, NULL | Primary country ISO code |
| RegionalUsage | TEXT | NULL | Regional usage information (JSON) |
| IntroductionDate | DATE | NULL | Currency introduction date |
| WithdrawalDate | DATE | NULL | Currency withdrawal date |
| ReplacedBy | VARCHAR(3) | FK, NULL | Replacement currency |
| ExchangeRateSource | VARCHAR(100) | NULL | Exchange rate data source |
| LastExchangeRateUpdate | TIMESTAMP | NULL | Last rate update timestamp |
| DefaultExchangeRate | DECIMAL(19,8) | NULL, CHECK > 0 | Default exchange rate to base |
| VolatilityRating | VARCHAR(10) | NULL | Volatility assessment |
| LiquidityRating | VARCHAR(10) | NULL | Market liquidity rating |
| RiskRating | VARCHAR(10) | NULL | Currency risk rating |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE Currency ADD CONSTRAINT PK_Currency PRIMARY KEY (CurrencyCode);

-- Unique Constraints
ALTER TABLE Currency ADD CONSTRAINT UK_Currency_NumericCode UNIQUE (CurrencyNumericCode);

-- Foreign Keys
ALTER TABLE Currency ADD CONSTRAINT FK_Currency_Country 
    FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode);
ALTER TABLE Currency ADD CONSTRAINT FK_Currency_ReplacedBy 
    FOREIGN KEY (ReplacedBy) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE Currency ADD CONSTRAINT CK_Currency_CurrencyCode 
    CHECK (CurrencyCode = UPPER(CurrencyCode) AND LEN(CurrencyCode) = 3);
ALTER TABLE Currency ADD CONSTRAINT CK_Currency_VolatilityRating 
    CHECK (VolatilityRating IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR VolatilityRating IS NULL);
ALTER TABLE Currency ADD CONSTRAINT CK_Currency_LiquidityRating 
    CHECK (LiquidityRating IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR LiquidityRating IS NULL);
ALTER TABLE Currency ADD CONSTRAINT CK_Currency_RiskRating 
    CHECK (RiskRating IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR RiskRating IS NULL);

-- Business Rules
ALTER TABLE Currency ADD CONSTRAINT CK_Currency_WithdrawalDate 
    CHECK (WithdrawalDate IS NULL OR WithdrawalDate > IntroductionDate);
ALTER TABLE Currency ADD CONSTRAINT CK_Currency_BaseCurrency 
    CHECK (NOT (IsBaseCurrency = 1 AND IsActive = 0));
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_Currency_CountryCode ON Currency(CountryCode);
CREATE INDEX IX_Currency_ReplacedBy ON Currency(ReplacedBy);

-- Lookup Indexes
CREATE INDEX IX_Currency_IsActive ON Currency(IsActive);
CREATE INDEX IX_Currency_IsBaseCurrency ON Currency(IsBaseCurrency);
CREATE INDEX IX_Currency_CurrencyName ON Currency(CurrencyName);

-- Date Indexes
CREATE INDEX IX_Currency_IntroductionDate ON Currency(IntroductionDate);
CREATE INDEX IX_Currency_WithdrawalDate ON Currency(WithdrawalDate);
CREATE INDEX IX_Currency_LastExchangeRateUpdate ON Currency(LastExchangeRateUpdate DESC);

-- Rating Indexes
CREATE INDEX IX_Currency_VolatilityRating ON Currency(VolatilityRating);
CREATE INDEX IX_Currency_RiskRating ON Currency(RiskRating);
```

---

## Entity: Country

### Purpose
Master country reference data with geographic, economic, and political information for risk assessment and compliance.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| CountryCode | VARCHAR(2) | PK, NOT NULL | ISO 3166-1 alpha-2 code |
| CountryCode3 | VARCHAR(3) | UK, NOT NULL | ISO 3166-1 alpha-3 code |
| CountryNumericCode | VARCHAR(3) | UK, NOT NULL | ISO 3166-1 numeric code |
| CountryName | VARCHAR(100) | NOT NULL | Official country name |
| CountryNameLocal | VARCHAR(100) | NULL | Local language name |
| ShortName | VARCHAR(50) | NOT NULL | Short country name |
| OfficialLanguages | TEXT | NULL | Official languages (JSON array) |
| RegionCode | VARCHAR(10) | FK, NOT NULL | Geographic region code |
| SubRegionCode | VARCHAR(10) | FK, NULL | Geographic sub-region code |
| ContinentCode | VARCHAR(2) | NOT NULL | Continent code |
| CapitalCity | VARCHAR(100) | NULL | Capital city name |
| LargestCity | VARCHAR(100) | NULL | Largest city name |
| Population | BIGINT | NULL, CHECK >= 0 | Population count |
| PopulationYear | INT | NULL, CHECK > 1900 | Population data year |
| LandAreaKm2 | DECIMAL(12,2) | NULL, CHECK >= 0 | Land area in km² |
| CoastlineKm | DECIMAL(10,2) | NULL, CHECK >= 0 | Coastline length in km |
| HighestElevationM | INT | NULL | Highest elevation in meters |
| LowestElevationM | INT | NULL | Lowest elevation in meters |
| TimeZones | TEXT | NULL | Time zones (JSON array) |
| CallingCode | VARCHAR(10) | NULL | International calling code |
| InternetTLD | VARCHAR(10) | NULL | Top-level domain |
| DrivingSide | VARCHAR(5) | NULL | Driving side (Left/Right) |
| DefaultCurrency | VARCHAR(3) | FK, NULL | Primary currency code |
| AlternateCurrencies | TEXT | NULL | Alternate currencies (JSON) |
| GDPTotalUSD | DECIMAL(19,2) | NULL, CHECK >= 0 | GDP total in USD |
| GDPPerCapitaUSD | DECIMAL(12,2) | NULL, CHECK >= 0 | GDP per capita in USD |
| GDPGrowthRate | DECIMAL(5,2) | NULL | GDP growth rate percentage |
| InflationRate | DECIMAL(5,2) | NULL | Inflation rate percentage |
| UnemploymentRate | DECIMAL(5,2) | NULL, CHECK >= 0 | Unemployment rate percentage |
| CorporateTaxRate | DECIMAL(5,2) | NULL, CHECK >= 0 | Corporate tax rate |
| VATRate | DECIMAL(5,2) | NULL, CHECK >= 0 | VAT/GST rate |
| EconomicComplexityIndex | DECIMAL(6,3) | NULL | Economic complexity index |
| GlobalCompetitivenessRank | INT | NULL, CHECK > 0 | Global competitiveness rank |
| EaseOfDoingBusinessRank | INT | NULL, CHECK > 0 | Ease of doing business rank |
| CorruptionPerceptionIndex | DECIMAL(4,1) | NULL, CHECK BETWEEN 0 AND 100 | CPI score |
| PoliticalStabilityIndex | DECIMAL(6,3) | NULL | Political stability index |
| RuleOfLawIndex | DECIMAL(6,3) | NULL | Rule of law index |
| GovernmentType | VARCHAR(50) | NULL | Government type |
| HeadOfState | VARCHAR(100) | NULL | Head of state |
| HeadOfGovernment | VARCHAR(100) | NULL | Head of government |
| IndependenceDate | DATE | NULL | Independence date |
| NationalHolidays | TEXT | NULL | National holidays (JSON) |
| BusinessDays | VARCHAR(20) | NULL | Business days pattern |
| WorkingHours | VARCHAR(50) | NULL | Standard working hours |
| ClimateZone | VARCHAR(50) | NULL | Climate classification |
| NaturalDisasterRisk | VARCHAR(10) | NULL | Natural disaster risk level |
| SeismicRisk | VARCHAR(10) | NULL | Earthquake risk level |
| FloodRisk | VARCHAR(10) | NULL | Flood risk level |
| CycloneRisk | VARCHAR(10) | NULL | Cyclone/hurricane risk |
| DroughtRisk | VARCHAR(10) | NULL | Drought risk level |
| EnvironmentalRiskIndex | DECIMAL(5,2) | NULL, CHECK >= 0 | Environmental risk score |
| ClimateChangeVulnerability | VARCHAR(10) | NULL | Climate change vulnerability |
| WaterStressLevel | VARCHAR(10) | NULL | Water stress level |
| EnergySecurityIndex | DECIMAL(5,2) | NULL | Energy security index |
| FoodSecurityIndex | DECIMAL(5,2) | NULL | Food security index |
| SocialStabilityIndex | DECIMAL(5,2) | NULL | Social stability index |
| HumanDevelopmentIndex | DECIMAL(5,3) | NULL, CHECK BETWEEN 0 AND 1 | HDI score |
| GenderInequalityIndex | DECIMAL(5,3) | NULL, CHECK >= 0 | Gender inequality index |
| IncomeInequalityGini | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Gini coefficient |
| LiteracyRate | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Adult literacy rate |
| HealthcareIndex | DECIMAL(5,2) | NULL | Healthcare quality index |
| EducationIndex | DECIMAL(5,3) | NULL, CHECK BETWEEN 0 AND 1 | Education index |
| InfrastructureQuality | DECIMAL(4,1) | NULL, CHECK BETWEEN 1 AND 7 | Infrastructure quality score |
| InternetPenetration | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Internet penetration rate |
| MobilePenetration | DECIMAL(5,2) | NULL, CHECK >= 0 | Mobile phone penetration |
| ElectricityAccess | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Electricity access rate |
| TransportationInfrastructure | DECIMAL(4,1) | NULL | Transportation infrastructure score |
| LogisticsPerformanceIndex | DECIMAL(3,2) | NULL | LPI score |
| PortEfficiencyIndex | DECIMAL(4,1) | NULL | Port efficiency score |
| AirportConnectivity | DECIMAL(5,1) | NULL | Airport connectivity score |
| BorderEfficiency | DECIMAL(4,1) | NULL | Border crossing efficiency |
| CustomsProcedures | DECIMAL(4,1) | NULL | Customs procedures efficiency |
| TradeAgreements | TEXT | NULL | Trade agreements (JSON array) |
| FreeTradeZones | TEXT | NULL | Free trade zones (JSON) |
| TaxTreaties | TEXT | NULL | Tax treaties (JSON array) |
| InvestmentTreaties | TEXT | NULL | Investment treaties (JSON) |
| RegionalBlocs | TEXT | NULL | Regional economic blocs (JSON) |
| InternationalOrganizations | TEXT | NULL | International memberships (JSON) |
| UN_MemberSince | DATE | NULL | UN membership date |
| WTO_MemberSince | DATE | NULL | WTO membership date |
| ComplianceFrameworks | TEXT | NULL | Compliance frameworks (JSON) |
| DataProtectionLaws | TEXT | NULL | Data protection regulations |
| CybersecurityFramework | VARCHAR(100) | NULL | Cybersecurity framework |
| IntellectualPropertyProtection | VARCHAR(10) | NULL | IP protection level |
| LaborLaws | TEXT | NULL | Labor law summary |
| EnvironmentalRegulations | TEXT | NULL | Environmental regulations |
| ImportRestrictions | TEXT | NULL | Import restrictions (JSON) |
| ExportRestrictions | TEXT | NULL | Export restrictions (JSON) |
| SanctionsStatus | VARCHAR(20) | NULL | International sanctions status |
| EmbargoStatus | VARCHAR(20) | NULL | Trade embargo status |
| MoneyLaunderingRisk | VARCHAR(10) | NULL | AML risk level |
| TerrorismRisk | VARCHAR(10) | NULL | Terrorism risk level |
| CyberThreatLevel | VARCHAR(10) | NULL | Cyber threat level |
| OrganizedCrimeLevel | VARCHAR(10) | NULL | Organized crime level |
| HumanTraffickingRisk | VARCHAR(10) | NULL | Human trafficking risk |
| DrugTraffickingRisk | VARCHAR(10) | NULL | Drug trafficking risk |
| CounterfeitingRisk | VARCHAR(10) | NULL | Counterfeiting risk |
| FraudRisk | VARCHAR(10) | NULL | Financial fraud risk |
| OverallRiskRating | VARCHAR(10) | NULL | Overall country risk rating |
| LastRiskAssessment | DATE | NULL | Last risk assessment date |
| NextRiskReview | DATE | NULL | Next scheduled review |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active country flag |
| IsRecognized | BOOLEAN | NOT NULL, DEFAULT TRUE | International recognition |
| IsSovereign | BOOLEAN | NOT NULL, DEFAULT TRUE | Sovereign state flag |
| IsIsland | BOOLEAN | NOT NULL, DEFAULT FALSE | Island nation flag |
| IsLandlocked | BOOLEAN | NOT NULL, DEFAULT FALSE | Landlocked flag |
| HasCoastline | BOOLEAN | NOT NULL, DEFAULT TRUE | Coastline flag |
| IsOilProducer | BOOLEAN | NOT NULL, DEFAULT FALSE | Oil producer flag |
| IsMineral_Rich | BOOLEAN | NOT NULL, DEFAULT FALSE | Mineral rich flag |
| IsAgriculturalEconomy | BOOLEAN | NOT NULL, DEFAULT FALSE | Agricultural economy flag |
| IsManufacturingHub | BOOLEAN | NOT NULL, DEFAULT FALSE | Manufacturing hub flag |
| IsServiceEconomy | BOOLEAN | NOT NULL, DEFAULT FALSE | Service economy flag |
| IsTechnologyHub | BOOLEAN | NOT NULL, DEFAULT FALSE | Technology hub flag |
| IsFinancialCenter | BOOLEAN | NOT NULL, DEFAULT FALSE | Financial center flag |
| IsTaxHaven | BOOLEAN | NOT NULL, DEFAULT FALSE | Tax haven flag |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE Country ADD CONSTRAINT PK_Country PRIMARY KEY (CountryCode);

-- Unique Constraints
ALTER TABLE Country ADD CONSTRAINT UK_Country_CountryCode3 UNIQUE (CountryCode3);
ALTER TABLE Country ADD CONSTRAINT UK_Country_NumericCode UNIQUE (CountryNumericCode);

-- Foreign Keys
ALTER TABLE Country ADD CONSTRAINT FK_Country_Region 
    FOREIGN KEY (RegionCode) REFERENCES GeographicRegion(RegionCode);
ALTER TABLE Country ADD CONSTRAINT FK_Country_SubRegion 
    FOREIGN KEY (SubRegionCode) REFERENCES GeographicRegion(RegionCode);
ALTER TABLE Country ADD CONSTRAINT FK_Country_DefaultCurrency 
    FOREIGN KEY (DefaultCurrency) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE Country ADD CONSTRAINT CK_Country_CountryCode 
    CHECK (CountryCode = UPPER(CountryCode) AND LEN(CountryCode) = 2);
ALTER TABLE Country ADD CONSTRAINT CK_Country_CountryCode3 
    CHECK (CountryCode3 = UPPER(CountryCode3) AND LEN(CountryCode3) = 3);
ALTER TABLE Country ADD CONSTRAINT CK_Country_ContinentCode 
    CHECK (ContinentCode IN ('AF', 'AS', 'EU', 'NA', 'SA', 'OC', 'AN'));
ALTER TABLE Country ADD CONSTRAINT CK_Country_DrivingSide 
    CHECK (DrivingSide IN ('Left', 'Right') OR DrivingSide IS NULL);

-- Risk level constraints
ALTER TABLE Country ADD CONSTRAINT CK_Country_RiskLevels 
    CHECK (
        (NaturalDisasterRisk IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR NaturalDisasterRisk IS NULL)
        AND (SeismicRisk IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR SeismicRisk IS NULL)
        AND (FloodRisk IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR FloodRisk IS NULL)
        AND (CycloneRisk IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR CycloneRisk IS NULL)
        AND (DroughtRisk IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR DroughtRisk IS NULL)
        AND (ClimateChangeVulnerability IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR ClimateChangeVulnerability IS NULL)
        AND (WaterStressLevel IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR WaterStressLevel IS NULL)
        AND (MoneyLaunderingRisk IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR MoneyLaunderingRisk IS NULL)
        AND (TerrorismRisk IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR TerrorismRisk IS NULL)
        AND (CyberThreatLevel IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR CyberThreatLevel IS NULL)
        AND (OverallRiskRating IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR OverallRiskRating IS NULL)
    );

-- Status constraints
ALTER TABLE Country ADD CONSTRAINT CK_Country_Status 
    CHECK (
        (SanctionsStatus IN ('None', 'Partial', 'Comprehensive', 'Targeted', 'Under Review') OR SanctionsStatus IS NULL)
        AND (EmbargoStatus IN ('None', 'Partial', 'Full', 'Arms', 'Economic') OR EmbargoStatus IS NULL)
        AND (IntellectualPropertyProtection IN ('Very Weak', 'Weak', 'Adequate', 'Strong', 'Very Strong') OR IntellectualPropertyProtection IS NULL)
    );
```

### Indexes

```sql
-- Unique Key Indexes (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_Country_RegionCode ON Country(RegionCode);
CREATE INDEX IX_Country_SubRegionCode ON Country(SubRegionCode);
CREATE INDEX IX_Country_DefaultCurrency ON Country(DefaultCurrency);

-- Name Search Indexes
CREATE INDEX IX_Country_CountryName ON Country(CountryName);
CREATE INDEX IX_Country_ShortName ON Country(ShortName);

-- Economic Indexes
CREATE INDEX IX_Country_GDPTotalUSD ON Country(GDPTotalUSD DESC);
CREATE INDEX IX_Country_GDPPerCapitaUSD ON Country(GDPPerCapitaUSD DESC);
CREATE INDEX IX_Country_GlobalCompetitivenessRank ON Country(GlobalCompetitivenessRank);

-- Risk Assessment Indexes
CREATE INDEX IX_Country_OverallRiskRating ON Country(OverallRiskRating);
CREATE INDEX IX_Country_PoliticalStabilityIndex ON Country(PoliticalStabilityIndex DESC);
CREATE INDEX IX_Country_CorruptionPerceptionIndex ON Country(CorruptionPerceptionIndex DESC);

-- Status Indexes
CREATE INDEX IX_Country_IsActive ON Country(IsActive);
CREATE INDEX IX_Country_SanctionsStatus ON Country(SanctionsStatus);
CREATE INDEX IX_Country_EmbargoStatus ON Country(EmbargoStatus);

-- Geographic Indexes
CREATE INDEX IX_Country_ContinentCode ON Country(ContinentCode);
CREATE INDEX IX_Country_IsLandlocked ON Country(IsLandlocked);
CREATE INDEX IX_Country_IsIsland ON Country(IsIsland);

-- Economic Classification Indexes
CREATE INDEX IX_Country_IsOilProducer ON Country(IsOilProducer);
CREATE INDEX IX_Country_IsManufacturingHub ON Country(IsManufacturingHub);
CREATE INDEX IX_Country_IsFinancialCenter ON Country(IsFinancialCenter);
CREATE INDEX IX_Country_IsTaxHaven ON Country(IsTaxHaven);

-- Composite Indexes
CREATE INDEX IX_Country_Region_Risk ON Country(RegionCode, OverallRiskRating);
CREATE INDEX IX_Country_Active_Risk ON Country(IsActive, OverallRiskRating);
CREATE INDEX IX_Country_GDP_Risk ON Country(GDPPerCapitaUSD DESC, OverallRiskRating);
```

---

## Entity: Language

### Purpose
Master language reference data for internationalization and localization support.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| LanguageCode | VARCHAR(2) | PK, NOT NULL | ISO 639-1 language code |
| LanguageCode3 | VARCHAR(3) | UK, NULL | ISO 639-2 language code |
| LanguageName | VARCHAR(100) | NOT NULL | English language name |
| NativeName | VARCHAR(100) | NULL | Native language name |
| LanguageFamily | VARCHAR(50) | NULL | Language family |
| ScriptType | VARCHAR(50) | NULL | Writing system |
| TextDirection | VARCHAR(10) | NOT NULL, DEFAULT 'LTR' | Text direction |
| IsOfficial | BOOLEAN | NOT NULL, DEFAULT FALSE | Official language flag |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active language flag |
| SpeakerCount | BIGINT | NULL, CHECK >= 0 | Number of speakers |
| CountriesUsed | TEXT | NULL | Countries using language (JSON) |
| RegionalVariants | TEXT | NULL | Regional variants (JSON) |
| LocalizationSupport | BOOLEAN | NOT NULL, DEFAULT FALSE | System localization available |
| TranslationQuality | VARCHAR(10) | NULL | Translation quality level |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE Language ADD CONSTRAINT PK_Language PRIMARY KEY (LanguageCode);

-- Unique Constraints
ALTER TABLE Language ADD CONSTRAINT UK_Language_LanguageCode3 UNIQUE (LanguageCode3);

-- Check Constraints
ALTER TABLE Language ADD CONSTRAINT CK_Language_LanguageCode 
    CHECK (LanguageCode = LOWER(LanguageCode) AND LEN(LanguageCode) = 2);
ALTER TABLE Language ADD CONSTRAINT CK_Language_TextDirection 
    CHECK (TextDirection IN ('LTR', 'RTL', 'TTB'));
ALTER TABLE Language ADD CONSTRAINT CK_Language_TranslationQuality 
    CHECK (TranslationQuality IN ('Excellent', 'Good', 'Fair', 'Poor', 'None') OR TranslationQuality IS NULL);
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Lookup Indexes
CREATE INDEX IX_Language_LanguageName ON Language(LanguageName);
CREATE INDEX IX_Language_IsActive ON Language(IsActive);
CREATE INDEX IX_Language_IsOfficial ON Language(IsOfficial);
CREATE INDEX IX_Language_LocalizationSupport ON Language(LocalizationSupport);
CREATE INDEX IX_Language_LanguageFamily ON Language(LanguageFamily);
```

---

## Entity: IndustryCode

### Purpose
Standard industry classification codes for supplier and category classification.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| IndustryCodeId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| CodeSystem | VARCHAR(20) | NOT NULL | Classification system (NAICS, SIC, etc.) |
| IndustryCode | VARCHAR(10) | NOT NULL | Industry code value |
| IndustryTitle | VARCHAR(255) | NOT NULL | Industry title/description |
| ParentCode | VARCHAR(10) | FK, NULL | Parent industry code |
| CodeLevel | INT | NOT NULL, DEFAULT 1, CHECK > 0 | Hierarchy level |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active code flag |
| EffectiveDate | DATE | NOT NULL | Code effective date |
| ExpirationDate | DATE | NULL | Code expiration date |
| RiskProfile | VARCHAR(10) | NULL | Industry risk profile |
| ComplianceRequirements | TEXT | NULL | Compliance requirements (JSON) |
| TypicalSuppliers | TEXT | NULL | Typical supplier characteristics |
| QualityStandards | TEXT | NULL | Quality standards (JSON) |
| CertificationRequirements | TEXT | NULL | Required certifications |
| EnvironmentalImpact | VARCHAR(10) | NULL | Environmental impact level |
| LaborIntensity | VARCHAR(10) | NULL | Labor intensity level |
| TechnologyIntensity | VARCHAR(10) | NULL | Technology intensity level |
| CapitalIntensity | VARCHAR(10) | NULL | Capital intensity level |
| RegulationLevel | VARCHAR(10) | NULL | Regulation intensity |
| SeasonalityFactor | VARCHAR(10) | NULL | Seasonality influence |
| CyclicalityFactor | VARCHAR(10) | NULL | Economic cyclicality |
| GlobalizationLevel | VARCHAR(10) | NULL | Globalization level |
| ConcentrationLevel | VARCHAR(10) | NULL | Market concentration |
| InnovationRate | VARCHAR(10) | NULL | Innovation rate |
| DisruptionRisk | VARCHAR(10) | NULL | Technology disruption risk |
| SupplyChainComplexity | VARCHAR(10) | NULL | Supply chain complexity |
| LogisticsComplexity | VARCHAR(10) | NULL | Logistics complexity |
| QualityRiskLevel | VARCHAR(10) | NULL | Quality risk level |
| DeliveryRiskLevel | VARCHAR(10) | NULL | Delivery risk level |
| CostVolatility | VARCHAR(10) | NULL | Cost volatility level |
| MarketVolatility | VARCHAR(10) | NULL | Market volatility |
| CompetitiveIntensity | VARCHAR(10) | NULL | Competitive intensity |
| BarriersToEntry | VARCHAR(10) | NULL | Market entry barriers |
| SwitchingCosts | VARCHAR(10) | NULL | Supplier switching costs |
| PowerBalance | VARCHAR(10) | NULL | Buyer-supplier power balance |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE IndustryCode ADD CONSTRAINT PK_IndustryCode PRIMARY KEY (IndustryCodeId);

-- Unique Constraints
ALTER TABLE IndustryCode ADD CONSTRAINT UK_IndustryCode_System_Code 
    UNIQUE (CodeSystem, IndustryCode);

-- Foreign Keys
ALTER TABLE IndustryCode ADD CONSTRAINT FK_IndustryCode_Parent 
    FOREIGN KEY (CodeSystem, ParentCode) REFERENCES IndustryCode(CodeSystem, IndustryCode);

-- Check Constraints
ALTER TABLE IndustryCode ADD CONSTRAINT CK_IndustryCode_CodeSystem 
    CHECK (CodeSystem IN ('NAICS', 'SIC', 'ISIC', 'NACE', 'ANZSIC', 'JSIC'));

-- Risk and intensity level constraints
ALTER TABLE IndustryCode ADD CONSTRAINT CK_IndustryCode_Levels 
    CHECK (
        (RiskProfile IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR RiskProfile IS NULL)
        AND (EnvironmentalImpact IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR EnvironmentalImpact IS NULL)
        AND (LaborIntensity IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR LaborIntensity IS NULL)
        AND (TechnologyIntensity IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR TechnologyIntensity IS NULL)
        AND (CapitalIntensity IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR CapitalIntensity IS NULL)
        AND (RegulationLevel IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR RegulationLevel IS NULL)
    );

-- Business Rules
ALTER TABLE IndustryCode ADD CONSTRAINT CK_IndustryCode_ExpirationDate 
    CHECK (ExpirationDate IS NULL OR ExpirationDate > EffectiveDate);
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes  
CREATE INDEX IX_IndustryCode_Parent ON IndustryCode(CodeSystem, ParentCode);

-- Classification Indexes
CREATE INDEX IX_IndustryCode_CodeSystem ON IndustryCode(CodeSystem);
CREATE INDEX IX_IndustryCode_CodeLevel ON IndustryCode(CodeLevel);
CREATE INDEX IX_IndustryCode_IsActive ON IndustryCode(IsActive);

-- Search Indexes
CREATE INDEX IX_IndustryCode_IndustryTitle ON IndustryCode(IndustryTitle);

-- Risk Assessment Indexes
CREATE INDEX IX_IndustryCode_RiskProfile ON IndustryCode(RiskProfile);
CREATE INDEX IX_IndustryCode_EnvironmentalImpact ON IndustryCode(EnvironmentalImpact);
CREATE INDEX IX_IndustryCode_DisruptionRisk ON IndustryCode(DisruptionRisk);

-- Date Indexes
CREATE INDEX IX_IndustryCode_EffectiveDate ON IndustryCode(EffectiveDate);
CREATE INDEX IX_IndustryCode_ExpirationDate ON IndustryCode(ExpirationDate);

-- Composite Indexes
CREATE INDEX IX_IndustryCode_Active_System ON IndustryCode(IsActive, CodeSystem);
CREATE INDEX IX_IndustryCode_System_Level ON IndustryCode(CodeSystem, CodeLevel);
```

---

## Entity: ComplianceFramework

### Purpose
Master reference for regulatory and compliance frameworks applicable to suppliers and operations.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| FrameworkId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| FrameworkCode | VARCHAR(20) | UK, NOT NULL | Framework identifier code |
| FrameworkName | VARCHAR(255) | NOT NULL | Framework full name |
| FrameworkType | VARCHAR(30) | NOT NULL | Regulatory, Industry, Voluntary, etc. |
| IssuingOrganization | VARCHAR(255) | NOT NULL | Issuing organization |
| GeographicScope | VARCHAR(20) | NOT NULL | Global, Regional, National, etc. |
| IndustryScope | TEXT | NULL | Applicable industries (JSON) |
| ApplicableCountries | TEXT | NULL | Countries where applicable (JSON) |
| Version | VARCHAR(20) | NULL | Framework version |
| EffectiveDate | DATE | NOT NULL | Effective date |
| LastRevisionDate | DATE | NULL | Last revision date |
| NextReviewDate | DATE | NULL | Next scheduled review |
| MandatoryCompliance | BOOLEAN | NOT NULL, DEFAULT FALSE | Mandatory compliance flag |
| CertificationRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Certification required flag |
| CertifyingBodies | TEXT | NULL | Authorized certifying bodies (JSON) |
| ComplianceLevel | VARCHAR(20) | NULL | Full, Partial, Conditional |
| RiskCategory | VARCHAR(20) | NULL | Risk category classification |
| PenaltyStructure | TEXT | NULL | Penalty structure (JSON) |
| AuditRequirements | TEXT | NULL | Audit requirements (JSON) |
| ReportingRequirements | TEXT | NULL | Reporting requirements (JSON) |
| DocumentationRequirements | TEXT | NULL | Required documentation (JSON) |
| TrainingRequirements | TEXT | NULL | Training requirements (JSON) |
| MonitoringRequirements | TEXT | NULL | Monitoring requirements (JSON) |
| AssessmentCriteria | TEXT | NULL | Assessment criteria (JSON) |
| ComplianceChecklist | TEXT | NULL | Compliance checklist (JSON) |
| ImplementationGuidance | TEXT | NULL | Implementation guidance |
| BestPractices | TEXT | NULL | Best practices (JSON) |
| CommonPitfalls | TEXT | NULL | Common compliance pitfalls |
| RelatedFrameworks | TEXT | NULL | Related frameworks (JSON) |
| ConflictingFrameworks | TEXT | NULL | Conflicting requirements (JSON) |
| SupersededBy | VARCHAR(20) | FK, NULL | Superseding framework |
| SupersededFrameworks | TEXT | NULL | Superseded frameworks (JSON) |
| ImplementationCost | VARCHAR(10) | NULL | Implementation cost level |
| MaintenanceCost | VARCHAR(10) | NULL | Maintenance cost level |
| ComplexityLevel | VARCHAR(10) | NULL | Implementation complexity |
| MaturityLevel | VARCHAR(10) | NULL | Framework maturity |
| AdoptionRate | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Industry adoption rate |
| EffectivenessRating | VARCHAR(10) | NULL | Effectiveness rating |
| StakeholderSupport | VARCHAR(10) | NULL | Stakeholder support level |
| BusinessImpact | VARCHAR(10) | NULL | Business impact level |
| CompetitiveAdvantage | BOOLEAN | NOT NULL, DEFAULT FALSE | Competitive advantage flag |
| CustomerRequirement | BOOLEAN | NOT NULL, DEFAULT FALSE | Customer requirement flag |
| ContractualRequirement | BOOLEAN | NOT NULL, DEFAULT FALSE | Contractual requirement flag |
| InsuranceRequirement | BOOLEAN | NOT NULL, DEFAULT FALSE | Insurance requirement flag |
| LicensingRequirement | BOOLEAN | NOT NULL, DEFAULT FALSE | Licensing requirement flag |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active framework flag |
| IsEmergingStandard | BOOLEAN | NOT NULL, DEFAULT FALSE | Emerging standard flag |
| IsDeprecated | BOOLEAN | NOT NULL, DEFAULT FALSE | Deprecated flag |
| DeprecationDate | DATE | NULL | Deprecation date |
| MigrationPath | TEXT | NULL | Migration path to replacement |
| TechnicalSpecifications | TEXT | NULL | Technical specifications |
| PerformanceMetrics | TEXT | NULL | Performance metrics (JSON) |
| BenchmarkingData | TEXT | NULL | Benchmarking data (JSON) |
| CaseStudies | TEXT | NULL | Implementation case studies |
| LessonsLearned | TEXT | NULL | Lessons learned |
| UpdateHistory | TEXT | NULL | Update history (JSON) |
| ContactInformation | TEXT | NULL | Contact information (JSON) |
| OfficialWebsite | VARCHAR(500) | NULL | Official website URL |
| DocumentationLinks | TEXT | NULL | Documentation links (JSON) |
| TrainingResources | TEXT | NULL | Training resources (JSON) |
| SupportResources | TEXT | NULL | Support resources (JSON) |
| CommunityResources | TEXT | NULL | Community resources (JSON) |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE ComplianceFramework ADD CONSTRAINT PK_ComplianceFramework PRIMARY KEY (FrameworkId);

-- Unique Constraints
ALTER TABLE ComplianceFramework ADD CONSTRAINT UK_ComplianceFramework_Code UNIQUE (FrameworkCode);

-- Foreign Keys
ALTER TABLE ComplianceFramework ADD CONSTRAINT FK_ComplianceFramework_SupersededBy 
    FOREIGN KEY (SupersededBy) REFERENCES ComplianceFramework(FrameworkCode);

-- Check Constraints
ALTER TABLE ComplianceFramework ADD CONSTRAINT CK_ComplianceFramework_Type 
    CHECK (FrameworkType IN ('Regulatory', 'Industry Standard', 'Voluntary', 'Certification', 
                           'Quality Management', 'Environmental', 'Safety', 'Security', 'Ethics'));
ALTER TABLE ComplianceFramework ADD CONSTRAINT CK_ComplianceFramework_GeographicScope 
    CHECK (GeographicScope IN ('Global', 'Regional', 'National', 'State/Province', 'Local'));
ALTER TABLE ComplianceFramework ADD CONSTRAINT CK_ComplianceFramework_ComplianceLevel 
    CHECK (ComplianceLevel IN ('Full', 'Partial', 'Conditional', 'Exempted') OR ComplianceLevel IS NULL);
ALTER TABLE ComplianceFramework ADD CONSTRAINT CK_ComplianceFramework_RiskCategory 
    CHECK (RiskCategory IN ('Critical', 'High', 'Medium', 'Low', 'Informational') OR RiskCategory IS NULL);

-- Level constraints
ALTER TABLE ComplianceFramework ADD CONSTRAINT CK_ComplianceFramework_Levels 
    CHECK (
        (ImplementationCost IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR ImplementationCost IS NULL)
        AND (MaintenanceCost IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR MaintenanceCost IS NULL)
        AND (ComplexityLevel IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR ComplexityLevel IS NULL)
        AND (MaturityLevel IN ('Initial', 'Developing', 'Defined', 'Managed', 'Optimizing') OR MaturityLevel IS NULL)
        AND (EffectivenessRating IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR EffectivenessRating IS NULL)
        AND (StakeholderSupport IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR StakeholderSupport IS NULL)
        AND (BusinessImpact IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR BusinessImpact IS NULL)
    );

-- Business Rules
ALTER TABLE ComplianceFramework ADD CONSTRAINT CK_ComplianceFramework_LastRevisionDate 
    CHECK (LastRevisionDate IS NULL OR LastRevisionDate >= EffectiveDate);
ALTER TABLE ComplianceFramework ADD CONSTRAINT CK_ComplianceFramework_DeprecationDate 
    CHECK (DeprecationDate IS NULL OR DeprecationDate > EffectiveDate);
ALTER TABLE ComplianceFramework ADD CONSTRAINT CK_ComplianceFramework_NextReviewDate 
    CHECK (NextReviewDate IS NULL OR NextReviewDate > EffectiveDate);
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_ComplianceFramework_SupersededBy ON ComplianceFramework(SupersededBy);

-- Classification Indexes
CREATE INDEX IX_ComplianceFramework_Type ON ComplianceFramework(FrameworkType);
CREATE INDEX IX_ComplianceFramework_GeographicScope ON ComplianceFramework(GeographicScope);
CREATE INDEX IX_ComplianceFramework_RiskCategory ON ComplianceFramework(RiskCategory);

-- Search Indexes
CREATE INDEX IX_ComplianceFramework_Name ON ComplianceFramework(FrameworkName);
CREATE INDEX IX_ComplianceFramework_IssuingOrganization ON ComplianceFramework(IssuingOrganization);

-- Status Indexes
CREATE INDEX IX_ComplianceFramework_IsActive ON ComplianceFramework(IsActive);
CREATE INDEX IX_ComplianceFramework_MandatoryCompliance ON ComplianceFramework(MandatoryCompliance);
CREATE INDEX IX_ComplianceFramework_CertificationRequired ON ComplianceFramework(CertificationRequired);

-- Date Indexes
CREATE INDEX IX_ComplianceFramework_EffectiveDate ON ComplianceFramework(EffectiveDate DESC);
CREATE INDEX IX_ComplianceFramework_LastRevisionDate ON ComplianceFramework(LastRevisionDate DESC);
CREATE INDEX IX_ComplianceFramework_NextReviewDate ON ComplianceFramework(NextReviewDate);

-- Assessment Indexes
CREATE INDEX IX_ComplianceFramework_ComplexityLevel ON ComplianceFramework(ComplexityLevel);
CREATE INDEX IX_ComplianceFramework_ImplementationCost ON ComplianceFramework(ImplementationCost);
CREATE INDEX IX_ComplianceFramework_EffectivenessRating ON ComplianceFramework(EffectivenessRating);

-- Boolean Flag Indexes
CREATE INDEX IX_ComplianceFramework_IsEmergingStandard ON ComplianceFramework(IsEmergingStandard);
CREATE INDEX IX_ComplianceFramework_IsDeprecated ON ComplianceFramework(IsDeprecated);
CREATE INDEX IX_ComplianceFramework_CustomerRequirement ON ComplianceFramework(CustomerRequirement);

-- Composite Indexes
CREATE INDEX IX_ComplianceFramework_Active_Type ON ComplianceFramework(IsActive, FrameworkType);
CREATE INDEX IX_ComplianceFramework_Scope_Risk ON ComplianceFramework(GeographicScope, RiskCategory);
CREATE INDEX IX_ComplianceFramework_Mandatory_Active ON ComplianceFramework(MandatoryCompliance, IsActive);
```

---

## Business Rules and Calculations

### Exchange Rate Management

```sql
-- Function to get current exchange rate
CREATE FUNCTION GetExchangeRate(
    @FromCurrency VARCHAR(3),
    @ToCurrency VARCHAR(3),
    @EffectiveDate DATE = NULL
)
RETURNS DECIMAL(19,8)
AS
BEGIN
    DECLARE @Rate DECIMAL(19,8) = 1.0;
    
    -- Default to current date if not specified
    IF @EffectiveDate IS NULL
        SET @EffectiveDate = CAST(GETDATE() AS DATE);
    
    -- Same currency
    IF @FromCurrency = @ToCurrency
        RETURN 1.0;
    
    -- Get exchange rate (simplified - would integrate with external rate service)
    SELECT TOP 1 @Rate = ExchangeRate
    FROM ExchangeRateHistory
    WHERE FromCurrency = @FromCurrency
      AND ToCurrency = @ToCurrency
      AND EffectiveDate <= @EffectiveDate
    ORDER BY EffectiveDate DESC;
    
    -- If no direct rate found, try inverse
    IF @Rate IS NULL
    BEGIN
        SELECT TOP 1 @Rate = 1.0 / ExchangeRate
        FROM ExchangeRateHistory
        WHERE FromCurrency = @ToCurrency
          AND ToCurrency = @FromCurrency
          AND EffectiveDate <= @EffectiveDate
        ORDER BY EffectiveDate DESC;
    END
    
    -- Use default rate from currency master if still not found
    IF @Rate IS NULL
    BEGIN
        SELECT @Rate = DefaultExchangeRate
        FROM Currency
        WHERE CurrencyCode = @FromCurrency;
    END
    
    RETURN ISNULL(@Rate, 1.0);
END;
```

### Country Risk Assessment

```sql
-- Stored procedure to update country risk ratings
CREATE PROCEDURE UpdateCountryRiskRatings
AS
BEGIN
    -- Calculate composite risk score
    UPDATE Country
    SET OverallRiskRating = 
        CASE 
            WHEN (
                CASE WHEN PoliticalStabilityIndex < -1.5 THEN 5
                     WHEN PoliticalStabilityIndex < -0.5 THEN 4
                     WHEN PoliticalStabilityIndex < 0.5 THEN 3
                     WHEN PoliticalStabilityIndex < 1.5 THEN 2
                     ELSE 1 END +
                CASE WHEN CorruptionPerceptionIndex < 30 THEN 5
                     WHEN CorruptionPerceptionIndex < 40 THEN 4
                     WHEN CorruptionPerceptionIndex < 60 THEN 3
                     WHEN CorruptionPerceptionIndex < 70 THEN 2
                     ELSE 1 END +
                CASE WHEN GlobalCompetitivenessRank > 100 THEN 5
                     WHEN GlobalCompetitivenessRank > 75 THEN 4
                     WHEN GlobalCompetitivenessRank > 50 THEN 3
                     WHEN GlobalCompetitivenessRank > 25 THEN 2
                     ELSE 1 END
            ) / 3.0 >= 4.5 THEN 'Very High'
            WHEN (
                CASE WHEN PoliticalStabilityIndex < -1.5 THEN 5
                     WHEN PoliticalStabilityIndex < -0.5 THEN 4
                     WHEN PoliticalStabilityIndex < 0.5 THEN 3
                     WHEN PoliticalStabilityIndex < 1.5 THEN 2
                     ELSE 1 END +
                CASE WHEN CorruptionPerceptionIndex < 30 THEN 5
                     WHEN CorruptionPerceptionIndex < 40 THEN 4
                     WHEN CorruptionPerceptionIndex < 60 THEN 3
                     WHEN CorruptionPerceptionIndex < 70 THEN 2
                     ELSE 1 END +
                CASE WHEN GlobalCompetitivenessRank > 100 THEN 5
                     WHEN GlobalCompetitivenessRank > 75 THEN 4
                     WHEN GlobalCompetitivenessRank > 50 THEN 3
                     WHEN GlobalCompetitivenessRank > 25 THEN 2
                     ELSE 1 END
            ) / 3.0 >= 3.5 THEN 'High'
            WHEN (
                CASE WHEN PoliticalStabilityIndex < -1.5 THEN 5
                     WHEN PoliticalStabilityIndex < -0.5 THEN 4
                     WHEN PoliticalStabilityIndex < 0.5 THEN 3
                     WHEN PoliticalStabilityIndex < 1.5 THEN 2
                     ELSE 1 END +
                CASE WHEN CorruptionPerceptionIndex < 30 THEN 5
                     WHEN CorruptionPerceptionIndex < 40 THEN 4
                     WHEN CorruptionPerceptionIndex < 60 THEN 3
                     WHEN CorruptionPerceptionIndex < 70 THEN 2
                     ELSE 1 END +
                CASE WHEN GlobalCompetitivenessRank > 100 THEN 5
                     WHEN GlobalCompetitivenessRank > 75 THEN 4
                     WHEN GlobalCompetitivenessRank > 50 THEN 3
                     WHEN GlobalCompetitivenessRank > 25 THEN 2
                     ELSE 1 END
            ) / 3.0 >= 2.5 THEN 'Medium'
            WHEN (
                CASE WHEN PoliticalStabilityIndex < -1.5 THEN 5
                     WHEN PoliticalStabilityIndex < -0.5 THEN 4
                     WHEN PoliticalStabilityIndex < 0.5 THEN 3
                     WHEN PoliticalStabilityIndex < 1.5 THEN 2
                     ELSE 1 END +
                CASE WHEN CorruptionPerceptionIndex < 30 THEN 5
                     WHEN CorruptionPerceptionIndex < 40 THEN 4
                     WHEN CorruptionPerceptionIndex < 60 THEN 3
                     WHEN CorruptionPerceptionIndex < 70 THEN 2
                     ELSE 1 END +
                CASE WHEN GlobalCompetitivenessRank > 100 THEN 5
                     WHEN GlobalCompetitivenessRank > 75 THEN 4
                     WHEN GlobalCompetitivenessRank > 50 THEN 3
                     WHEN GlobalCompetitivenessRank > 25 THEN 2
                     ELSE 1 END
            ) / 3.0 >= 1.5 THEN 'Low'
            ELSE 'Very Low'
        END,
        LastRiskAssessment = CAST(GETDATE() AS DATE),
        NextRiskReview = DATEADD(month, 6, CAST(GETDATE() AS DATE)),
        ModifiedDate = GETDATE(),
        ModifiedBy = 'SYSTEM'
    WHERE PoliticalStabilityIndex IS NOT NULL
      AND CorruptionPerceptionIndex IS NOT NULL
      AND GlobalCompetitivenessRank IS NOT NULL;
END;
```

---

## Data Quality Rules

### Reference Data Integrity
- All reference codes must be unique within their classification system
- Currency and country relationships must be validated against official sources
- Exchange rates must be updated regularly from authoritative sources
- Industry codes must maintain hierarchical consistency

### Compliance Framework Management
- Framework versions must be tracked with effective dates
- Superseded frameworks must maintain historical linkages
- Mandatory compliance requirements must be clearly flagged
- Geographic and industry applicability must be well-defined

### Localization Support
- Language codes must follow ISO standards
- Regional variants must be properly categorized
- Translation quality must be assessed and maintained
- Text direction and script types must be accurate

---

*Document Version*: 1.0  
*Last Updated*: August 21, 2025  
*Next Review*: September 21, 2025  
*Document Owner*: Master Data Management Team
