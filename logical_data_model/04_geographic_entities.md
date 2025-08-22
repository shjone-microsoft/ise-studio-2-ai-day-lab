# Geographic Entities - Logical Data Model

## Overview
This document defines the logical structure for geographic data management, regional classifications, and location-based risk assessment.

---

## Entity: GeographicRegion

### Purpose
Hierarchical geographic classification system supporting regional sourcing strategies and risk assessment.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| RegionId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| RegionCode | VARCHAR(20) | UK, NOT NULL | Business region identifier |
| RegionName | VARCHAR(255) | NOT NULL | Region display name |
| RegionType | VARCHAR(20) | NOT NULL | Continent, Country, State, Economic Zone |
| ParentRegionId | BIGINT | FK, NULL | Reference to parent region |
| RegionLevel | INT | NOT NULL, DEFAULT 1 | Hierarchy level (1=top level) |
| RegionPath | VARCHAR(1000) | NOT NULL | Full hierarchical path |
| ISO3166Alpha2Code | VARCHAR(2) | NULL | ISO country code (if country) |
| ISO3166Alpha3Code | VARCHAR(3) | NULL | ISO 3-letter country code |
| ISO3166NumericCode | VARCHAR(3) | NULL | ISO numeric country code |
| CurrencyCode | VARCHAR(3) | FK, NULL | Primary currency |
| LanguageCode | VARCHAR(2) | FK, NULL | Primary language |
| TimeZone | VARCHAR(50) | NULL | Primary time zone |
| GeographicCenterLatitude | DECIMAL(10,8) | NULL | Geographic center latitude |
| GeographicCenterLongitude | DECIMAL(11,8) | NULL | Geographic center longitude |
| EconomicZone | VARCHAR(100) | NULL | Economic zone (EU, NAFTA, etc.) |
| TradingBloc | VARCHAR(100) | NULL | Trading bloc membership |
| PoliticalRiskScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Political stability risk score |
| EconomicRiskScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Economic stability risk score |
| InfrastructureScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Infrastructure quality score |
| BusinessClimateScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Business environment score |
| CorruptionPerceptionIndex | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Transparency International CPI |
| EaseOfDoingBusinessRank | INT | NULL, CHECK > 0 | World Bank EODB ranking |
| LogisticsPerformanceIndex | DECIMAL(5,2) | NULL, CHECK 0.00-5.00 | World Bank LPI score |
| CompetitivenessIndex | DECIMAL(5,2) | NULL, CHECK 0.00-7.00 | WEF Global Competitiveness Index |
| PopulationCount | BIGINT | NULL, CHECK >= 0 | Total population |
| GDPAmount | DECIMAL(19,4) | NULL, CHECK >= 0 | Gross Domestic Product |
| GDPCurrencyCode | VARCHAR(3) | FK, NULL | GDP currency |
| GDPPerCapita | DECIMAL(15,2) | NULL, CHECK >= 0 | GDP per capita |
| InflationRate | DECIMAL(5,2) | NULL | Current inflation rate % |
| UnemploymentRate | DECIMAL(5,2) | NULL, CHECK >= 0 | Unemployment rate % |
| CorporateTaxRate | DECIMAL(5,2) | NULL, CHECK >= 0 | Corporate tax rate % |
| IsSourcingRestricted | BOOLEAN | NOT NULL, DEFAULT FALSE | Sourcing restrictions flag |
| RestrictionReason | TEXT | NULL | Reason for sourcing restrictions |
| IsHighRiskRegion | BOOLEAN | NOT NULL, DEFAULT FALSE | High-risk region flag |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active region flag |
| LastRiskAssessmentDate | DATE | NULL | Last risk assessment date |
| NextRiskAssessmentDate | DATE | NULL | Next scheduled risk assessment |
| DataSourceProvider | VARCHAR(100) | NULL | Primary data source |
| LastDataUpdate | TIMESTAMP | NULL | Last data update timestamp |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE GeographicRegion ADD CONSTRAINT PK_GeographicRegion PRIMARY KEY (RegionId);

-- Unique Constraints
ALTER TABLE GeographicRegion ADD CONSTRAINT UK_GeographicRegion_RegionCode UNIQUE (RegionCode);
ALTER TABLE GeographicRegion ADD CONSTRAINT UK_GeographicRegion_ISO3166Alpha2 UNIQUE (ISO3166Alpha2Code);
ALTER TABLE GeographicRegion ADD CONSTRAINT UK_GeographicRegion_ISO3166Alpha3 UNIQUE (ISO3166Alpha3Code);

-- Foreign Keys
ALTER TABLE GeographicRegion ADD CONSTRAINT FK_GeographicRegion_ParentRegion 
    FOREIGN KEY (ParentRegionId) REFERENCES GeographicRegion(RegionId);
ALTER TABLE GeographicRegion ADD CONSTRAINT FK_GeographicRegion_Currency 
    FOREIGN KEY (CurrencyCode) REFERENCES Currency(CurrencyCode);
ALTER TABLE GeographicRegion ADD CONSTRAINT FK_GeographicRegion_GDPCurrency 
    FOREIGN KEY (GDPCurrencyCode) REFERENCES Currency(CurrencyCode);
ALTER TABLE GeographicRegion ADD CONSTRAINT FK_GeographicRegion_Language 
    FOREIGN KEY (LanguageCode) REFERENCES Language(LanguageCode);

-- Check Constraints
ALTER TABLE GeographicRegion ADD CONSTRAINT CK_GeographicRegion_RegionType 
    CHECK (RegionType IN ('Global', 'Continent', 'Economic Zone', 'Country', 'State/Province', 
                          'Region', 'Metropolitan Area', 'City', 'Custom'));
ALTER TABLE GeographicRegion ADD CONSTRAINT CK_GeographicRegion_RegionLevel 
    CHECK (RegionLevel >= 1 AND RegionLevel <= 10);
ALTER TABLE GeographicRegion ADD CONSTRAINT CK_GeographicRegion_LatitudeRange 
    CHECK (GeographicCenterLatitude IS NULL OR GeographicCenterLatitude BETWEEN -90 AND 90);
ALTER TABLE GeographicRegion ADD CONSTRAINT CK_GeographicRegion_LongitudeRange 
    CHECK (GeographicCenterLongitude IS NULL OR GeographicCenterLongitude BETWEEN -180 AND 180);

-- Business Rules
ALTER TABLE GeographicRegion ADD CONSTRAINT CK_GeographicRegion_CoordinatePair 
    CHECK ((GeographicCenterLatitude IS NULL AND GeographicCenterLongitude IS NULL) OR 
           (GeographicCenterLatitude IS NOT NULL AND GeographicCenterLongitude IS NOT NULL));
ALTER TABLE GeographicRegion ADD CONSTRAINT CK_GeographicRegion_NextAssessmentDate 
    CHECK (NextRiskAssessmentDate IS NULL OR NextRiskAssessmentDate > LastRiskAssessmentDate OR LastRiskAssessmentDate IS NULL);
```

### Indexes

```sql
-- Unique Key Indexes (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_GeographicRegion_ParentRegionId ON GeographicRegion(ParentRegionId);
CREATE INDEX IX_GeographicRegion_CurrencyCode ON GeographicRegion(CurrencyCode);
CREATE INDEX IX_GeographicRegion_GDPCurrencyCode ON GeographicRegion(GDPCurrencyCode);
CREATE INDEX IX_GeographicRegion_LanguageCode ON GeographicRegion(LanguageCode);

-- Hierarchy Navigation Indexes
CREATE INDEX IX_GeographicRegion_RegionLevel ON GeographicRegion(RegionLevel);
CREATE INDEX IX_GeographicRegion_RegionPath ON GeographicRegion(RegionPath);
CREATE INDEX IX_GeographicRegion_RegionType ON GeographicRegion(RegionType);

-- Risk and Business Climate Indexes
CREATE INDEX IX_GeographicRegion_PoliticalRiskScore ON GeographicRegion(PoliticalRiskScore DESC);
CREATE INDEX IX_GeographicRegion_EconomicRiskScore ON GeographicRegion(EconomicRiskScore DESC);
CREATE INDEX IX_GeographicRegion_IsHighRiskRegion ON GeographicRegion(IsHighRiskRegion);
CREATE INDEX IX_GeographicRegion_IsSourcingRestricted ON GeographicRegion(IsSourcingRestricted);

-- Economic Data Indexes
CREATE INDEX IX_GeographicRegion_GDPAmount ON GeographicRegion(GDPAmount DESC);
CREATE INDEX IX_GeographicRegion_GDPPerCapita ON GeographicRegion(GDPPerCapita DESC);

-- Assessment Date Indexes
CREATE INDEX IX_GeographicRegion_LastRiskAssessmentDate ON GeographicRegion(LastRiskAssessmentDate);
CREATE INDEX IX_GeographicRegion_NextRiskAssessmentDate ON GeographicRegion(NextRiskAssessmentDate);

-- Geospatial Indexes (if supported)
CREATE SPATIAL INDEX IX_GeographicRegion_Coordinates ON GeographicRegion(GeographicCenterLatitude, GeographicCenterLongitude);

-- Composite Indexes
CREATE INDEX IX_GeographicRegion_Active_Type ON GeographicRegion(IsActive, RegionType);
CREATE INDEX IX_GeographicRegion_Level_Parent ON GeographicRegion(RegionLevel, ParentRegionId);
```

---

## Entity: CountryProfile

### Purpose
Detailed country-specific information for procurement and supply chain decisions.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| CountryId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| GeographicRegionId | BIGINT | FK, NOT NULL | Reference to geographic region |
| CountryCode | VARCHAR(2) | UK, NOT NULL | ISO 3166-1 alpha-2 code |
| CountryName | VARCHAR(255) | NOT NULL | Official country name |
| OfficialLanguages | VARCHAR(255) | NULL | Comma-separated language codes |
| CapitalCity | VARCHAR(100) | NULL | Capital city name |
| ContinentCode | VARCHAR(2) | NULL | Continent code |
| PrimaryCurrency | VARCHAR(3) | FK, NOT NULL | Primary currency code |
| SecondaryCurrencies | VARCHAR(100) | NULL | Other accepted currencies |
| PoliticalSystem | VARCHAR(50) | NULL | Government type |
| LegalSystem | VARCHAR(50) | NULL | Legal system type |
| TradeAgreements | TEXT | NULL | Active trade agreements |
| FreeTradeZones | TEXT | NULL | Free trade zone information |
| ImportDutyRates | TEXT | NULL | General import duty information |
| ExportRestrictions | TEXT | NULL | Export restriction information |
| SanctionsStatus | VARCHAR(50) | NULL | International sanctions status |
| AntiCorruptionLaws | TEXT | NULL | Anti-corruption regulations |
| LaborLaws | TEXT | NULL | Key labor law information |
| EnvironmentalRegulations | TEXT | NULL | Environmental compliance requirements |
| DataPrivacyLaws | TEXT | NULL | Data protection regulations |
| IntellectualPropertyLaws | TEXT | NULL | IP protection information |
| CyberSecurityRegulations | TEXT | NULL | Cybersecurity requirements |
| BusinessRegistrationProcess | TEXT | NULL | Business setup requirements |
| TaxTreatyCountries | VARCHAR(1000) | NULL | Tax treaty partner countries |
| MinimumWageAmount | DECIMAL(15,2) | NULL, CHECK >= 0 | Minimum wage amount |
| MinimumWageCurrency | VARCHAR(3) | FK, NULL | Minimum wage currency |
| WorkingHoursPerWeek | DECIMAL(5,2) | NULL, CHECK > 0 | Standard working hours |
| PublicHolidays | TEXT | NULL | Major public holidays |
| BusinessCulture | TEXT | NULL | Cultural considerations |
| NegotiationStyle | TEXT | NULL | Business negotiation style |
| PaymentTermsNorms | VARCHAR(255) | NULL | Standard payment terms |
| ContractLawFramework | TEXT | NULL | Contract law information |
| DisputeResolutionMechanisms | TEXT | NULL | Dispute resolution options |
| BankingSystem | TEXT | NULL | Banking and financial system info |
| TransportationInfrastructure | TEXT | NULL | Transportation capabilities |
| TelecommunicationInfrastructure | TEXT | NULL | Telecom capabilities |
| EnergyInfrastructure | TEXT | NULL | Energy infrastructure info |
| NaturalDisasterRisks | TEXT | NULL | Natural disaster exposure |
| ClimateZone | VARCHAR(50) | NULL | Climate classification |
| SeasonalConsiderations | TEXT | NULL | Seasonal business factors |
| QualityCertificationBodies | TEXT | NULL | National certification authorities |
| IndustryAssociations | TEXT | NULL | Key industry associations |
| RegulatoryAuthorities | TEXT | NULL | Key regulatory bodies |
| TradePromotionOrganizations | TEXT | NULL | Trade promotion agencies |
| IsEUMember | BOOLEAN | NOT NULL, DEFAULT FALSE | European Union membership |
| IsNATOMember | BOOLEAN | NOT NULL, DEFAULT FALSE | NATO membership |
| IsG7Member | BOOLEAN | NOT NULL, DEFAULT FALSE | G7 membership |
| IsG20Member | BOOLEAN | NOT NULL, DEFAULT FALSE | G20 membership |
| IsOECDMember | BOOLEAN | NOT NULL, DEFAULT FALSE | OECD membership |
| UNDevelopmentIndex | DECIMAL(5,3) | NULL, CHECK 0.000-1.000 | Human Development Index |
| DoingBusinessRank | INT | NULL, CHECK > 0 | World Bank Doing Business rank |
| DataLastUpdated | TIMESTAMP | NOT NULL | Last comprehensive data update |
| DataSources | TEXT | NOT NULL | Data source citations |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE CountryProfile ADD CONSTRAINT PK_CountryProfile PRIMARY KEY (CountryId);

-- Unique Constraints
ALTER TABLE CountryProfile ADD CONSTRAINT UK_CountryProfile_CountryCode UNIQUE (CountryCode);
ALTER TABLE CountryProfile ADD CONSTRAINT UK_CountryProfile_GeographicRegion UNIQUE (GeographicRegionId);

-- Foreign Keys
ALTER TABLE CountryProfile ADD CONSTRAINT FK_CountryProfile_GeographicRegion 
    FOREIGN KEY (GeographicRegionId) REFERENCES GeographicRegion(RegionId);
ALTER TABLE CountryProfile ADD CONSTRAINT FK_CountryProfile_PrimaryCurrency 
    FOREIGN KEY (PrimaryCurrency) REFERENCES Currency(CurrencyCode);
ALTER TABLE CountryProfile ADD CONSTRAINT FK_CountryProfile_MinimumWageCurrency 
    FOREIGN KEY (MinimumWageCurrency) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE CountryProfile ADD CONSTRAINT CK_CountryProfile_SanctionsStatus 
    CHECK (SanctionsStatus IN ('None', 'Partial', 'Comprehensive', 'Under Review', 'Lifted') OR SanctionsStatus IS NULL);
```

### Indexes

```sql
-- Unique Key Indexes (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_CountryProfile_GeographicRegionId ON CountryProfile(GeographicRegionId);
CREATE INDEX IX_CountryProfile_PrimaryCurrency ON CountryProfile(PrimaryCurrency);
CREATE INDEX IX_CountryProfile_MinimumWageCurrency ON CountryProfile(MinimumWageCurrency);

-- Search and Filter Indexes
CREATE INDEX IX_CountryProfile_ContinentCode ON CountryProfile(ContinentCode);
CREATE INDEX IX_CountryProfile_PoliticalSystem ON CountryProfile(PoliticalSystem);
CREATE INDEX IX_CountryProfile_SanctionsStatus ON CountryProfile(SanctionsStatus);

-- Membership Indexes
CREATE INDEX IX_CountryProfile_IsEUMember ON CountryProfile(IsEUMember);
CREATE INDEX IX_CountryProfile_IsOECDMember ON CountryProfile(IsOECDMember);

-- Performance Indexes
CREATE INDEX IX_CountryProfile_UNDevelopmentIndex ON CountryProfile(UNDevelopmentIndex DESC);
CREATE INDEX IX_CountryProfile_DoingBusinessRank ON CountryProfile(DoingBusinessRank);

-- Composite Indexes
CREATE INDEX IX_CountryProfile_Continent_Development ON CountryProfile(ContinentCode, UNDevelopmentIndex DESC);
```

---

## Entity: TradeLane

### Purpose
Manages trade routes and corridors between geographic regions for logistics and risk planning.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| TradeLaneId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| TradeLaneName | VARCHAR(255) | NOT NULL | Trade lane description |
| OriginRegionId | BIGINT | FK, NOT NULL | Origin geographic region |
| DestinationRegionId | BIGINT | FK, NOT NULL | Destination geographic region |
| TransportMode | VARCHAR(20) | NOT NULL | Sea, Air, Land, Multimodal |
| TransportProvider | VARCHAR(255) | NULL | Primary logistics provider |
| AverageTransitTime | DECIMAL(8,2) | NULL, CHECK >= 0 | Average transit time in days |
| MinimumTransitTime | DECIMAL(8,2) | NULL, CHECK >= 0 | Minimum transit time in days |
| MaximumTransitTime | DECIMAL(8,2) | NULL, CHECK >= 0 | Maximum transit time in days |
| AverageFreightCost | DECIMAL(15,2) | NULL, CHECK >= 0 | Average freight cost |
| FreightCostCurrency | VARCHAR(3) | FK, NULL | Freight cost currency |
| FreightCostUnit | VARCHAR(50) | NULL | Cost per unit (TEU, kg, cbm) |
| CapacityUtilization | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Current capacity utilization % |
| ReliabilityScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | On-time delivery reliability |
| SecurityRiskLevel | VARCHAR(10) | NULL | Low, Medium, High, Critical |
| WeatherRiskLevel | VARCHAR(10) | NULL | Low, Medium, High, Critical |
| PoliticalRiskLevel | VARCHAR(10) | NULL | Low, Medium, High, Critical |
| InfrastructureRiskLevel | VARCHAR(10) | NULL | Low, Medium, High, Critical |
| OverallRiskScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Composite risk score |
| CustomsClearanceTime | DECIMAL(8,2) | NULL, CHECK >= 0 | Average customs time in days |
| DocumentationRequirements | TEXT | NULL | Required documentation |
| RestrictedCommodities | TEXT | NULL | Commodity restrictions |
| SeasonalFactors | TEXT | NULL | Seasonal considerations |
| AlternativeRoutes | TEXT | NULL | Alternative route options |
| KeyPorts | TEXT | NULL | Major ports/hubs on route |
| FreightForwarders | TEXT | NULL | Recommended freight forwarders |
| InsuranceRequirements | TEXT | NULL | Insurance considerations |
| TrackingCapabilities | TEXT | NULL | Shipment tracking options |
| DigitalCapabilities | TEXT | NULL | Digital platform support |
| CarbonFootprint | DECIMAL(10,4) | NULL, CHECK >= 0 | CO2 emissions per unit |
| EnvironmentalRating | VARCHAR(10) | NULL | Environmental impact rating |
| VolumeLastYear | DECIMAL(15,2) | NULL, CHECK >= 0 | Previous year volume |
| VolumeUnit | VARCHAR(20) | NULL | Volume measurement unit |
| GrowthTrend | VARCHAR(15) | NULL | Growing, Stable, Declining |
| MarketSharePct | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Market share percentage |
| CompetitiveIntensity | VARCHAR(10) | NULL | Low, Medium, High |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active trade lane flag |
| IsPreferred | BOOLEAN | NOT NULL, DEFAULT FALSE | Preferred route flag |
| LastPerformanceReview | DATE | NULL | Last performance review date |
| NextPerformanceReview | DATE | NULL | Next scheduled review |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE TradeLane ADD CONSTRAINT PK_TradeLane PRIMARY KEY (TradeLaneId);

-- Foreign Keys
ALTER TABLE TradeLane ADD CONSTRAINT FK_TradeLane_OriginRegion 
    FOREIGN KEY (OriginRegionId) REFERENCES GeographicRegion(RegionId);
ALTER TABLE TradeLane ADD CONSTRAINT FK_TradeLane_DestinationRegion 
    FOREIGN KEY (DestinationRegionId) REFERENCES GeographicRegion(RegionId);
ALTER TABLE TradeLane ADD CONSTRAINT FK_TradeLane_FreightCurrency 
    FOREIGN KEY (FreightCostCurrency) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE TradeLane ADD CONSTRAINT CK_TradeLane_TransportMode 
    CHECK (TransportMode IN ('Sea', 'Air', 'Land', 'Rail', 'Multimodal', 'Pipeline'));
ALTER TABLE TradeLane ADD CONSTRAINT CK_TradeLane_SecurityRiskLevel 
    CHECK (SecurityRiskLevel IN ('Low', 'Medium', 'High', 'Critical') OR SecurityRiskLevel IS NULL);
ALTER TABLE TradeLane ADD CONSTRAINT CK_TradeLane_WeatherRiskLevel 
    CHECK (WeatherRiskLevel IN ('Low', 'Medium', 'High', 'Critical') OR WeatherRiskLevel IS NULL);
ALTER TABLE TradeLane ADD CONSTRAINT CK_TradeLane_PoliticalRiskLevel 
    CHECK (PoliticalRiskLevel IN ('Low', 'Medium', 'High', 'Critical') OR PoliticalRiskLevel IS NULL);
ALTER TABLE TradeLane ADD CONSTRAINT CK_TradeLane_InfrastructureRiskLevel 
    CHECK (InfrastructureRiskLevel IN ('Low', 'Medium', 'High', 'Critical') OR InfrastructureRiskLevel IS NULL);
ALTER TABLE TradeLane ADD CONSTRAINT CK_TradeLane_GrowthTrend 
    CHECK (GrowthTrend IN ('Growing', 'Stable', 'Declining') OR GrowthTrend IS NULL);
ALTER TABLE TradeLane ADD CONSTRAINT CK_TradeLane_CompetitiveIntensity 
    CHECK (CompetitiveIntensity IN ('Low', 'Medium', 'High') OR CompetitiveIntensity IS NULL);
ALTER TABLE TradeLane ADD CONSTRAINT CK_TradeLane_EnvironmentalRating 
    CHECK (EnvironmentalRating IN ('A', 'B', 'C', 'D', 'F') OR EnvironmentalRating IS NULL);

-- Business Rules
ALTER TABLE TradeLane ADD CONSTRAINT CK_TradeLane_DifferentRegions 
    CHECK (OriginRegionId != DestinationRegionId);
ALTER TABLE TradeLane ADD CONSTRAINT CK_TradeLane_TransitTimes 
    CHECK (MaximumTransitTime IS NULL OR MinimumTransitTime IS NULL OR MaximumTransitTime >= MinimumTransitTime);
ALTER TABLE TradeLane ADD CONSTRAINT CK_TradeLane_NextReviewDate 
    CHECK (NextPerformanceReview IS NULL OR LastPerformanceReview IS NULL OR NextPerformanceReview > LastPerformanceReview);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_TradeLane_OriginRegionId ON TradeLane(OriginRegionId);
CREATE INDEX IX_TradeLane_DestinationRegionId ON TradeLane(DestinationRegionId);
CREATE INDEX IX_TradeLane_FreightCostCurrency ON TradeLane(FreightCostCurrency);

-- Search and Filter Indexes
CREATE INDEX IX_TradeLane_TransportMode ON TradeLane(TransportMode);
CREATE INDEX IX_TradeLane_IsActive ON TradeLane(IsActive);
CREATE INDEX IX_TradeLane_IsPreferred ON TradeLane(IsPreferred);

-- Performance Indexes
CREATE INDEX IX_TradeLane_OverallRiskScore ON TradeLane(OverallRiskScore DESC);
CREATE INDEX IX_TradeLane_ReliabilityScore ON TradeLane(ReliabilityScore DESC);
CREATE INDEX IX_TradeLane_AverageFreightCost ON TradeLane(AverageFreightCost);
CREATE INDEX IX_TradeLane_AverageTransitTime ON TradeLane(AverageTransitTime);

-- Review Date Indexes
CREATE INDEX IX_TradeLane_NextPerformanceReview ON TradeLane(NextPerformanceReview);

-- Composite Indexes
CREATE INDEX IX_TradeLane_Origin_Destination ON TradeLane(OriginRegionId, DestinationRegionId);
CREATE INDEX IX_TradeLane_Mode_Active ON TradeLane(TransportMode, IsActive);
CREATE INDEX IX_TradeLane_Risk_Reliability ON TradeLane(OverallRiskScore, ReliabilityScore DESC);
```

---

## Reference Tables

### Entity: Currency

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| CurrencyCode | VARCHAR(3) | PK, NOT NULL | ISO 4217 currency code |
| CurrencyName | VARCHAR(100) | NOT NULL | Currency name |
| CurrencySymbol | VARCHAR(10) | NULL | Currency symbol |
| MinorUnit | INT | NOT NULL, DEFAULT 2 | Number of decimal places |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active currency flag |

### Entity: Language

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| LanguageCode | VARCHAR(2) | PK, NOT NULL | ISO 639-1 language code |
| LanguageName | VARCHAR(100) | NOT NULL | Language name |
| NativeName | VARCHAR(100) | NULL | Native language name |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active language flag |

---

## Business Rules and Calculations

### Geographic Risk Assessment

```sql
-- Function to calculate overall geographic risk score
CREATE FUNCTION CalculateGeographicRiskScore(
    @PoliticalRisk DECIMAL(5,2),
    @EconomicRisk DECIMAL(5,2),
    @InfrastructureScore DECIMAL(5,2),
    @BusinessClimateScore DECIMAL(5,2)
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @OverallRisk DECIMAL(5,2);
    
    -- Weighted calculation
    SELECT @OverallRisk = (
        (@PoliticalRisk * 0.30) +
        (@EconomicRisk * 0.30) +
        ((100 - @InfrastructureScore) * 0.25) +  -- Lower infrastructure = higher risk
        ((100 - @BusinessClimateScore) * 0.15)   -- Lower business climate = higher risk
    );
    
    RETURN @OverallRisk;
END;
```

### Trade Lane Optimization

```sql
-- Stored procedure to find optimal trade lanes
CREATE PROCEDURE FindOptimalTradeLanes(
    @OriginRegionId BIGINT,
    @DestinationRegionId BIGINT,
    @MaxRiskScore DECIMAL(5,2) = 50.00,
    @MaxTransitDays DECIMAL(8,2) = NULL
)
AS
BEGIN
    SELECT 
        tl.*,
        (tl.OverallRiskScore * 0.4 + 
         ((tl.AverageTransitTime / 30.0) * 100 * 0.3) +
         ((tl.AverageFreightCost / 1000.0) * 0.3)) AS OptimizationScore
    FROM TradeLane tl
    WHERE tl.OriginRegionId = @OriginRegionId
      AND tl.DestinationRegionId = @DestinationRegionId
      AND tl.IsActive = 1
      AND (tl.OverallRiskScore IS NULL OR tl.OverallRiskScore <= @MaxRiskScore)
      AND (@MaxTransitDays IS NULL OR tl.AverageTransitTime IS NULL OR tl.AverageTransitTime <= @MaxTransitDays)
    ORDER BY OptimizationScore;
END;
```

### Regional Hierarchy Management

```sql
-- Function to calculate region path
CREATE FUNCTION CalculateRegionPath(@RegionId BIGINT)
RETURNS VARCHAR(1000)
AS
BEGIN
    DECLARE @Path VARCHAR(1000) = '';
    DECLARE @CurrentId BIGINT = @RegionId;
    DECLARE @CurrentCode VARCHAR(20);
    
    WHILE @CurrentId IS NOT NULL
    BEGIN
        SELECT @CurrentCode = RegionCode, @CurrentId = ParentRegionId
        FROM GeographicRegion
        WHERE RegionId = @CurrentId;
        
        IF @Path = ''
            SET @Path = @CurrentCode;
        ELSE
            SET @Path = @CurrentCode + '/' + @Path;
    END
    
    RETURN @Path;
END;
```

---

## Data Quality Rules

### Geographic Region Management
- Region codes must be unique and follow naming conventions
- Regional hierarchy must not have circular references
- Country-level regions must have valid ISO codes
- Risk scores must be updated regularly from trusted sources

### Country Profile Management
- Country profiles must be linked to exactly one country-level geographic region
- ISO country codes must be valid and unique
- Economic data must be updated at least annually
- Regulatory information must be current and sourced

### Trade Lane Management
- Trade lanes must connect different regions
- Performance metrics must be updated regularly
- Risk assessments must consider multiple factors
- Alternative routes should be documented for critical lanes

---

*Document Version*: 1.0  
*Last Updated*: August 21, 2025  
*Next Review*: September 21, 2025  
*Document Owner*: Global Sourcing Team
