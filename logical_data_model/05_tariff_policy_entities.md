# Tariff Policy Entities - Logical Data Model

## Overview
This document defines the logical structure for tariff policy management, trade policy tracking, and tariff impact assessment for dynamic supplier risk scoring.

---

## Entity: TariffPolicy

### Purpose
Comprehensive tracking of trade policies, tariff rates, and policy changes affecting procurement costs and supplier selection.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| TariffPolicyId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| PolicyCode | VARCHAR(50) | UK, NOT NULL | Business policy identifier |
| PolicyName | VARCHAR(255) | NOT NULL | Policy display name |
| PolicyType | VARCHAR(20) | NOT NULL | Tariff, Trade Agreement, Sanction, etc. |
| IssuingCountryCode | VARCHAR(2) | FK, NOT NULL | Country implementing policy |
| TargetCountryCode | VARCHAR(2) | FK, NULL | Target country (null if multi-country) |
| TargetCountries | TEXT | NULL | Multiple target countries (JSON array) |
| PolicyDescription | TEXT | NOT NULL | Detailed policy description |
| PolicyObjective | TEXT | NULL | Policy objective/rationale |
| LegalFramework | VARCHAR(255) | NULL | Legal authority/framework |
| RegulatoryAuthority | VARCHAR(255) | NOT NULL | Implementing agency/authority |
| AnnouncementDate | DATE | NULL | Policy announcement date |
| EffectiveDate | DATE | NOT NULL | Policy effective start date |
| ExpirationDate | DATE | NULL | Policy expiration date |
| LastModificationDate | DATE | NULL | Last policy modification |
| PolicyStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Active' | Draft, Active, Suspended, Expired, Repealed |
| ReviewFrequency | VARCHAR(20) | NULL | Review schedule |
| NextReviewDate | DATE | NULL | Next scheduled review |
| ImpactScope | VARCHAR(20) | NOT NULL | Global, Regional, Bilateral, Unilateral |
| ProductCategoriesAffected | TEXT | NULL | Affected product categories (JSON) |
| IndustryCodesAffected | TEXT | NULL | Affected industry codes (JSON) |
| HarmonizedSystemCodes | TEXT | NULL | HS codes affected (JSON) |
| TariffType | VARCHAR(20) | NULL | Ad Valorem, Specific, Compound, Quota |
| BaseTariffRate | DECIMAL(8,4) | NULL, CHECK >= 0 | Base tariff rate |
| TariffRateUnit | VARCHAR(20) | NULL | Percentage, per unit, per kg, etc. |
| MinimumTariff | DECIMAL(15,2) | NULL, CHECK >= 0 | Minimum tariff amount |
| MaximumTariff | DECIMAL(15,2) | NULL, CHECK >= 0 | Maximum tariff amount |
| TariffCurrency | VARCHAR(3) | FK, NULL | Currency for tariff amounts |
| QuotaLimit | DECIMAL(15,2) | NULL, CHECK >= 0 | Quota limit if applicable |
| QuotaUnit | VARCHAR(50) | NULL | Quota measurement unit |
| QuotaPeriod | VARCHAR(20) | NULL | Quota period (Annual, Monthly, etc.) |
| ExemptionCriteria | TEXT | NULL | Exemption conditions |
| PreferentialRates | TEXT | NULL | Special rates for certain countries |
| SafeguardMeasures | TEXT | NULL | Safeguard provisions |
| AntiDumpingProvisions | TEXT | NULL | Anti-dumping measures |
| CountervailingDuties | TEXT | NULL | Countervailing duty information |
| OriginRules | TEXT | NULL | Rules of origin requirements |
| CertificationRequirements | TEXT | NULL | Required certifications |
| DocumentationRequirements | TEXT | NULL | Required documentation |
| ComplianceProcedures | TEXT | NULL | Compliance procedures |
| PenaltiesForViolation | TEXT | NULL | Penalty structure |
| DisputeResolutionMechanism | TEXT | NULL | Dispute resolution process |
| RelatedPolicies | TEXT | NULL | Related policy references |
| SupersededPolicyId | BIGINT | FK, NULL | Reference to superseded policy |
| HistoricalTariffRates | TEXT | NULL | Historical rate changes (JSON) |
| EconomicImpactAssessment | TEXT | NULL | Economic impact analysis |
| BusinessImpactCategories | TEXT | NULL | Business impact areas |
| EstimatedCostImpact | DECIMAL(19,4) | NULL | Estimated cost impact amount |
| CostImpactCurrency | VARCHAR(3) | FK, NULL | Cost impact currency |
| CostImpactTimeframe | VARCHAR(20) | NULL | Impact timeframe (Annual, etc.) |
| AffectedTradeVolume | DECIMAL(19,4) | NULL, CHECK >= 0 | Affected trade volume |
| TradeVolumeUnit | VARCHAR(50) | NULL | Trade volume unit |
| MonitoringFrequency | VARCHAR(20) | NOT NULL, DEFAULT 'Monthly' | Monitoring schedule |
| AlertThresholds | TEXT | NULL | Alert threshold configurations |
| DataSources | TEXT | NOT NULL | Data source references |
| ConfidenceLevel | DECIMAL(5,2) | NOT NULL, DEFAULT 85.00, CHECK 0.00-100.00 | Data confidence level |
| LastVerifiedDate | DATE | NULL | Last verification date |
| VerificationSource | VARCHAR(255) | NULL | Verification source |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active policy flag |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE TariffPolicy ADD CONSTRAINT PK_TariffPolicy PRIMARY KEY (TariffPolicyId);

-- Unique Constraints
ALTER TABLE TariffPolicy ADD CONSTRAINT UK_TariffPolicy_PolicyCode UNIQUE (PolicyCode);

-- Foreign Keys
ALTER TABLE TariffPolicy ADD CONSTRAINT FK_TariffPolicy_IssuingCountry 
    FOREIGN KEY (IssuingCountryCode) REFERENCES GeographicRegion(ISO3166Alpha2Code);
ALTER TABLE TariffPolicy ADD CONSTRAINT FK_TariffPolicy_TargetCountry 
    FOREIGN KEY (TargetCountryCode) REFERENCES GeographicRegion(ISO3166Alpha2Code);
ALTER TABLE TariffPolicy ADD CONSTRAINT FK_TariffPolicy_TariffCurrency 
    FOREIGN KEY (TariffCurrency) REFERENCES Currency(CurrencyCode);
ALTER TABLE TariffPolicy ADD CONSTRAINT FK_TariffPolicy_CostImpactCurrency 
    FOREIGN KEY (CostImpactCurrency) REFERENCES Currency(CurrencyCode);
ALTER TABLE TariffPolicy ADD CONSTRAINT FK_TariffPolicy_SupersededPolicy 
    FOREIGN KEY (SupersededPolicyId) REFERENCES TariffPolicy(TariffPolicyId);

-- Check Constraints
ALTER TABLE TariffPolicy ADD CONSTRAINT CK_TariffPolicy_PolicyType 
    CHECK (PolicyType IN ('Tariff', 'Trade Agreement', 'Sanction', 'Quota', 'Embargo', 
                          'Preference', 'Anti-Dumping', 'Countervailing', 'Safeguard'));
ALTER TABLE TariffPolicy ADD CONSTRAINT CK_TariffPolicy_PolicyStatus 
    CHECK (PolicyStatus IN ('Draft', 'Proposed', 'Active', 'Suspended', 'Expired', 'Repealed', 'Under Review'));
ALTER TABLE TariffPolicy ADD CONSTRAINT CK_TariffPolicy_ImpactScope 
    CHECK (ImpactScope IN ('Global', 'Regional', 'Bilateral', 'Unilateral', 'Multilateral'));
ALTER TABLE TariffPolicy ADD CONSTRAINT CK_TariffPolicy_TariffType 
    CHECK (TariffType IN ('Ad Valorem', 'Specific', 'Compound', 'Quota', 'Prohibitive') OR TariffType IS NULL);
ALTER TABLE TariffPolicy ADD CONSTRAINT CK_TariffPolicy_ReviewFrequency 
    CHECK (ReviewFrequency IN ('Weekly', 'Monthly', 'Quarterly', 'Semi-Annual', 'Annual', 'Bi-Annual') OR ReviewFrequency IS NULL);
ALTER TABLE TariffPolicy ADD CONSTRAINT CK_TariffPolicy_QuotaPeriod 
    CHECK (QuotaPeriod IN ('Daily', 'Weekly', 'Monthly', 'Quarterly', 'Annual', 'Calendar Year') OR QuotaPeriod IS NULL);
ALTER TABLE TariffPolicy ADD CONSTRAINT CK_TariffPolicy_MonitoringFrequency 
    CHECK (MonitoringFrequency IN ('Daily', 'Weekly', 'Monthly', 'Quarterly'));

-- Business Rules
ALTER TABLE TariffPolicy ADD CONSTRAINT CK_TariffPolicy_EffectiveDates 
    CHECK (ExpirationDate IS NULL OR ExpirationDate > EffectiveDate);
ALTER TABLE TariffPolicy ADD CONSTRAINT CK_TariffPolicy_AnnouncementDate 
    CHECK (AnnouncementDate IS NULL OR AnnouncementDate <= EffectiveDate);
ALTER TABLE TariffPolicy ADD CONSTRAINT CK_TariffPolicy_TariffAmounts 
    CHECK (MaximumTariff IS NULL OR MinimumTariff IS NULL OR MaximumTariff >= MinimumTariff);
ALTER TABLE TariffPolicy ADD CONSTRAINT CK_TariffPolicy_NextReviewDate 
    CHECK (NextReviewDate IS NULL OR NextReviewDate >= EffectiveDate);
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_TariffPolicy_IssuingCountryCode ON TariffPolicy(IssuingCountryCode);
CREATE INDEX IX_TariffPolicy_TargetCountryCode ON TariffPolicy(TargetCountryCode);
CREATE INDEX IX_TariffPolicy_TariffCurrency ON TariffPolicy(TariffCurrency);
CREATE INDEX IX_TariffPolicy_CostImpactCurrency ON TariffPolicy(CostImpactCurrency);
CREATE INDEX IX_TariffPolicy_SupersededPolicyId ON TariffPolicy(SupersededPolicyId);

-- Status and Date Indexes
CREATE INDEX IX_TariffPolicy_PolicyStatus ON TariffPolicy(PolicyStatus);
CREATE INDEX IX_TariffPolicy_EffectiveDate ON TariffPolicy(EffectiveDate DESC);
CREATE INDEX IX_TariffPolicy_ExpirationDate ON TariffPolicy(ExpirationDate);
CREATE INDEX IX_TariffPolicy_NextReviewDate ON TariffPolicy(NextReviewDate);
CREATE INDEX IX_TariffPolicy_AnnouncementDate ON TariffPolicy(AnnouncementDate DESC);

-- Policy Classification Indexes
CREATE INDEX IX_TariffPolicy_PolicyType ON TariffPolicy(PolicyType);
CREATE INDEX IX_TariffPolicy_ImpactScope ON TariffPolicy(ImpactScope);
CREATE INDEX IX_TariffPolicy_TariffType ON TariffPolicy(TariffType);

-- Impact and Monitoring Indexes
CREATE INDEX IX_TariffPolicy_BaseTariffRate ON TariffPolicy(BaseTariffRate DESC);
CREATE INDEX IX_TariffPolicy_EstimatedCostImpact ON TariffPolicy(EstimatedCostImpact DESC);
CREATE INDEX IX_TariffPolicy_ConfidenceLevel ON TariffPolicy(ConfidenceLevel DESC);

-- Active Policy Indexes
CREATE INDEX IX_TariffPolicy_IsActive ON TariffPolicy(IsActive);

-- Composite Indexes for Common Queries
CREATE INDEX IX_TariffPolicy_Status_Effective ON TariffPolicy(PolicyStatus, EffectiveDate DESC);
CREATE INDEX IX_TariffPolicy_Country_Status ON TariffPolicy(IssuingCountryCode, PolicyStatus);
CREATE INDEX IX_TariffPolicy_Type_Active ON TariffPolicy(PolicyType, IsActive);
CREATE INDEX IX_TariffPolicy_Active_Review ON TariffPolicy(IsActive, NextReviewDate);

-- Full-text indexes for description searches (if supported)
CREATE FULLTEXT INDEX FTI_TariffPolicy_Description ON TariffPolicy(PolicyDescription);
```

---

## Entity: TariffRateHistory

### Purpose
Historical tracking of tariff rate changes for trend analysis and impact assessment.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| RateHistoryId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| TariffPolicyId | BIGINT | FK, NOT NULL | Reference to tariff policy |
| EffectiveDate | DATE | NOT NULL | Rate change effective date |
| PreviousRate | DECIMAL(8,4) | NULL, CHECK >= 0 | Previous tariff rate |
| NewRate | DECIMAL(8,4) | NOT NULL, CHECK >= 0 | New tariff rate |
| RateChange | DECIMAL(8,4) | NOT NULL | Rate change amount |
| PercentageChange | DECIMAL(5,2) | NOT NULL | Percentage change |
| ChangeReason | TEXT | NOT NULL | Reason for rate change |
| ChangeType | VARCHAR(20) | NOT NULL | Increase, Decrease, New, Suspension |
| AnnouncementDate | DATE | NULL | Change announcement date |
| ImplementationLag | INT | NULL, CHECK >= 0 | Days between announcement and implementation |
| ImpactAssessment | TEXT | NULL | Impact assessment |
| AffectedProducts | TEXT | NULL | Products affected by change |
| AffectedSuppliers | TEXT | NULL | Suppliers affected by change |
| EstimatedCostImpact | DECIMAL(19,4) | NULL | Estimated cost impact |
| CostImpactCurrency | VARCHAR(3) | FK, NULL | Cost impact currency |
| BusinessResponse | TEXT | NULL | Business response actions |
| MarketReaction | TEXT | NULL | Market reaction information |
| CompetitorAnalysis | TEXT | NULL | Competitor response analysis |
| DataSource | VARCHAR(255) | NOT NULL | Change notification source |
| VerificationStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Unverified' | Unverified, Verified, Disputed |
| VerifiedBy | VARCHAR(100) | NULL | Verification source |
| VerificationDate | DATE | NULL | Verification date |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active rate flag |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |

### Constraints

```sql
-- Primary Key
ALTER TABLE TariffRateHistory ADD CONSTRAINT PK_TariffRateHistory PRIMARY KEY (RateHistoryId);

-- Foreign Keys
ALTER TABLE TariffRateHistory ADD CONSTRAINT FK_TariffRateHistory_TariffPolicy 
    FOREIGN KEY (TariffPolicyId) REFERENCES TariffPolicy(TariffPolicyId) ON DELETE CASCADE;
ALTER TABLE TariffRateHistory ADD CONSTRAINT FK_TariffRateHistory_Currency 
    FOREIGN KEY (CostImpactCurrency) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE TariffRateHistory ADD CONSTRAINT CK_TariffRateHistory_ChangeType 
    CHECK (ChangeType IN ('Increase', 'Decrease', 'New', 'Suspension', 'Reinstatement', 'Elimination'));
ALTER TABLE TariffRateHistory ADD CONSTRAINT CK_TariffRateHistory_VerificationStatus 
    CHECK (VerificationStatus IN ('Unverified', 'Verified', 'Disputed', 'Rejected'));

-- Business Rules
ALTER TABLE TariffRateHistory ADD CONSTRAINT CK_TariffRateHistory_AnnouncementDate 
    CHECK (AnnouncementDate IS NULL OR AnnouncementDate <= EffectiveDate);
ALTER TABLE TariffRateHistory ADD CONSTRAINT CK_TariffRateHistory_VerificationDate 
    CHECK (VerificationDate IS NULL OR VerificationDate >= EffectiveDate);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_TariffRateHistory_TariffPolicyId ON TariffRateHistory(TariffPolicyId);
CREATE INDEX IX_TariffRateHistory_CostImpactCurrency ON TariffRateHistory(CostImpactCurrency);

-- Date-based Indexes
CREATE INDEX IX_TariffRateHistory_EffectiveDate ON TariffRateHistory(EffectiveDate DESC);
CREATE INDEX IX_TariffRateHistory_AnnouncementDate ON TariffRateHistory(AnnouncementDate DESC);
CREATE INDEX IX_TariffRateHistory_CreatedDate ON TariffRateHistory(CreatedDate DESC);

-- Analysis Indexes
CREATE INDEX IX_TariffRateHistory_ChangeType ON TariffRateHistory(ChangeType);
CREATE INDEX IX_TariffRateHistory_PercentageChange ON TariffRateHistory(PercentageChange DESC);
CREATE INDEX IX_TariffRateHistory_VerificationStatus ON TariffRateHistory(VerificationStatus);

-- Composite Indexes
CREATE INDEX IX_TariffRateHistory_Policy_Date ON TariffRateHistory(TariffPolicyId, EffectiveDate DESC);
CREATE INDEX IX_TariffRateHistory_Type_Date ON TariffRateHistory(ChangeType, EffectiveDate DESC);

-- Partitioning by EffectiveDate (monthly partitions for performance)
```

---

## Entity: TariffImpactAssessment

### Purpose
Assesses the impact of tariff policies on specific suppliers, categories, and business operations.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| ImpactAssessmentId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| TariffPolicyId | BIGINT | FK, NOT NULL | Reference to tariff policy |
| AssessmentDate | TIMESTAMP | NOT NULL | Assessment creation date |
| AssessmentType | VARCHAR(20) | NOT NULL | Supplier, Category, Portfolio, Global |
| SupplierId | BIGINT | FK, NULL | Specific supplier (if applicable) |
| CategoryId | BIGINT | FK, NULL | Specific category (if applicable) |
| GeographicRegionId | BIGINT | FK, NULL | Specific region (if applicable) |
| AssessmentScope | VARCHAR(255) | NOT NULL | Scope description |
| CurrentAnnualSpend | DECIMAL(19,4) | NOT NULL, CHECK >= 0 | Current annual spend |
| SpendCurrency | VARCHAR(3) | FK, NOT NULL | Spend currency |
| AffectedSpendAmount | DECIMAL(19,4) | NOT NULL, CHECK >= 0 | Spend affected by tariff |
| AffectedSpendPercentage | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | % of spend affected |
| CurrentTariffRate | DECIMAL(8,4) | NULL, CHECK >= 0 | Current applicable tariff rate |
| NewTariffRate | DECIMAL(8,4) | NOT NULL, CHECK >= 0 | New tariff rate |
| TariffRateChange | DECIMAL(8,4) | NOT NULL | Tariff rate change |
| EstimatedAnnualCostIncrease | DECIMAL(19,4) | NOT NULL, CHECK >= 0 | Estimated annual cost increase |
| CostIncreasePercentage | DECIMAL(5,2) | NOT NULL, CHECK >= 0 | Cost increase percentage |
| OneTimeCostImpact | DECIMAL(19,4) | NULL, CHECK >= 0 | One-time implementation costs |
| OngoingCostImpact | DECIMAL(19,4) | NOT NULL, CHECK >= 0 | Ongoing annual cost impact |
| ComplianceCosts | DECIMAL(15,2) | NULL, CHECK >= 0 | Additional compliance costs |
| AdministrativeCosts | DECIMAL(15,2) | NULL, CHECK >= 0 | Additional administrative costs |
| RiskMitigationCosts | DECIMAL(15,2) | NULL, CHECK >= 0 | Risk mitigation costs |
| TotalEstimatedImpact | DECIMAL(19,4) | NOT NULL, CHECK >= 0 | Total financial impact |
| PaybackPeriod | DECIMAL(8,2) | NULL, CHECK > 0 | Mitigation investment payback (months) |
| ImpactTimeframe | VARCHAR(20) | NOT NULL | Immediate, Short-term, Long-term |
| ImpactSeverity | VARCHAR(10) | NOT NULL | Low, Medium, High, Critical |
| BusinessContinuityRisk | VARCHAR(10) | NOT NULL | Low, Medium, High, Critical |
| CompetitiveImpact | TEXT | NULL | Impact on competitive position |
| CustomerImpact | TEXT | NULL | Impact on customer pricing |
| SupplierNegotiationPower | TEXT | NULL | Change in supplier leverage |
| AlternativeSupplierOptions | TEXT | NULL | Alternative sourcing options |
| GeographicDiversificationOpportunities | TEXT | NULL | Geographic alternatives |
| ProductSubstitutionOptions | TEXT | NULL | Product substitution possibilities |
| RecommendedActions | TEXT | NOT NULL | Recommended response actions |
| ActionPriority | VARCHAR(10) | NOT NULL, DEFAULT 'Medium' | Low, Medium, High, Urgent |
| ImplementationTimeframe | VARCHAR(20) | NULL | Action implementation timeline |
| ResponsibleParty | VARCHAR(100) | NULL | Party responsible for actions |
| ContingencyPlans | TEXT | NULL | Contingency planning options |
| MonitoringRequirements | TEXT | NULL | Ongoing monitoring needs |
| EscalationCriteria | TEXT | NULL | Escalation triggers |
| ReviewFrequency | VARCHAR(20) | NOT NULL, DEFAULT 'Monthly' | Assessment review frequency |
| NextReviewDate | DATE | NOT NULL | Next assessment review |
| ConfidenceLevel | DECIMAL(5,2) | NOT NULL, DEFAULT 75.00, CHECK 0.00-100.00 | Assessment confidence |
| DataQuality | VARCHAR(10) | NOT NULL, DEFAULT 'Good' | Excellent, Good, Fair, Poor |
| Assumptions | TEXT | NOT NULL | Key assumptions made |
| Limitations | TEXT | NULL | Assessment limitations |
| Status | VARCHAR(15) | NOT NULL, DEFAULT 'Draft' | Draft, Under Review, Approved, Superseded |
| ApprovedBy | VARCHAR(100) | NULL | Assessment approver |
| ApprovedDate | TIMESTAMP | NULL | Approval timestamp |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT PK_TariffImpactAssessment PRIMARY KEY (ImpactAssessmentId);

-- Foreign Keys
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT FK_TariffImpactAssessment_TariffPolicy 
    FOREIGN KEY (TariffPolicyId) REFERENCES TariffPolicy(TariffPolicyId);
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT FK_TariffImpactAssessment_Supplier 
    FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId);
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT FK_TariffImpactAssessment_Category 
    FOREIGN KEY (CategoryId) REFERENCES ProductCategory(CategoryId);
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT FK_TariffImpactAssessment_GeographicRegion 
    FOREIGN KEY (GeographicRegionId) REFERENCES GeographicRegion(RegionId);
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT FK_TariffImpactAssessment_Currency 
    FOREIGN KEY (SpendCurrency) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT CK_TariffImpactAssessment_AssessmentType 
    CHECK (AssessmentType IN ('Supplier', 'Category', 'Portfolio', 'Global', 'Regional'));
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT CK_TariffImpactAssessment_ImpactTimeframe 
    CHECK (ImpactTimeframe IN ('Immediate', 'Short-term', 'Medium-term', 'Long-term'));
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT CK_TariffImpactAssessment_ImpactSeverity 
    CHECK (ImpactSeverity IN ('Low', 'Medium', 'High', 'Critical'));
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT CK_TariffImpactAssessment_BusinessContinuityRisk 
    CHECK (BusinessContinuityRisk IN ('Low', 'Medium', 'High', 'Critical'));
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT CK_TariffImpactAssessment_ActionPriority 
    CHECK (ActionPriority IN ('Low', 'Medium', 'High', 'Urgent'));
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT CK_TariffImpactAssessment_DataQuality 
    CHECK (DataQuality IN ('Excellent', 'Good', 'Fair', 'Poor'));
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT CK_TariffImpactAssessment_Status 
    CHECK (Status IN ('Draft', 'Under Review', 'Approved', 'Superseded', 'Archived'));
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT CK_TariffImpactAssessment_ReviewFrequency 
    CHECK (ReviewFrequency IN ('Weekly', 'Monthly', 'Quarterly', 'Semi-Annual', 'Annual'));

-- Business Rules
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT CK_TariffImpactAssessment_AffectedSpend 
    CHECK (AffectedSpendAmount <= CurrentAnnualSpend);
ALTER TABLE TariffImpactAssessment ADD CONSTRAINT CK_TariffImpactAssessment_ApprovalDate 
    CHECK (ApprovedDate IS NULL OR ApprovedDate >= AssessmentDate);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_TariffImpactAssessment_TariffPolicyId ON TariffImpactAssessment(TariffPolicyId);
CREATE INDEX IX_TariffImpactAssessment_SupplierId ON TariffImpactAssessment(SupplierId);
CREATE INDEX IX_TariffImpactAssessment_CategoryId ON TariffImpactAssessment(CategoryId);
CREATE INDEX IX_TariffImpactAssessment_GeographicRegionId ON TariffImpactAssessment(GeographicRegionId);
CREATE INDEX IX_TariffImpactAssessment_SpendCurrency ON TariffImpactAssessment(SpendCurrency);

-- Date-based Indexes
CREATE INDEX IX_TariffImpactAssessment_AssessmentDate ON TariffImpactAssessment(AssessmentDate DESC);
CREATE INDEX IX_TariffImpactAssessment_NextReviewDate ON TariffImpactAssessment(NextReviewDate);
CREATE INDEX IX_TariffImpactAssessment_ApprovedDate ON TariffImpactAssessment(ApprovedDate DESC);

-- Impact Analysis Indexes
CREATE INDEX IX_TariffImpactAssessment_ImpactSeverity ON TariffImpactAssessment(ImpactSeverity);
CREATE INDEX IX_TariffImpactAssessment_TotalEstimatedImpact ON TariffImpactAssessment(TotalEstimatedImpact DESC);
CREATE INDEX IX_TariffImpactAssessment_CostIncreasePercentage ON TariffImpactAssessment(CostIncreasePercentage DESC);

-- Status and Priority Indexes
CREATE INDEX IX_TariffImpactAssessment_Status ON TariffImpactAssessment(Status);
CREATE INDEX IX_TariffImpactAssessment_ActionPriority ON TariffImpactAssessment(ActionPriority);

-- Composite Indexes
CREATE INDEX IX_TariffImpactAssessment_Policy_Severity ON TariffImpactAssessment(TariffPolicyId, ImpactSeverity);
CREATE INDEX IX_TariffImpactAssessment_Status_Review ON TariffImpactAssessment(Status, NextReviewDate);
CREATE INDEX IX_TariffImpactAssessment_Type_Impact ON TariffImpactAssessment(AssessmentType, TotalEstimatedImpact DESC);
```

---

## Entity: TradeAgreement

### Purpose
Manages trade agreements and preferential trading arrangements affecting supplier costs and selection.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| TradeAgreementId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| AgreementCode | VARCHAR(50) | UK, NOT NULL | Agreement identifier |
| AgreementName | VARCHAR(255) | NOT NULL | Official agreement name |
| AgreementType | VARCHAR(20) | NOT NULL | FTA, Customs Union, Economic Partnership |
| ParticipatingCountries | TEXT | NOT NULL | Participating countries (JSON) |
| LeadCountries | VARCHAR(255) | NULL | Lead negotiating countries |
| NegotiationStartDate | DATE | NULL | Negotiation start date |
| SigningDate | DATE | NULL | Agreement signing date |
| RatificationDate | DATE | NULL | Ratification completion date |
| EffectiveDate | DATE | NOT NULL | Agreement effective date |
| ExpirationDate | DATE | NULL | Agreement expiration date |
| RenewalProvisions | TEXT | NULL | Renewal terms and conditions |
| AgreementScope | TEXT | NOT NULL | Scope and coverage description |
| TariffReductions | TEXT | NULL | Tariff reduction schedules |
| ProductCoverage | TEXT | NULL | Products covered by agreement |
| ServiceCoverage | TEXT | NULL | Services covered by agreement |
| OriginRules | TEXT | NULL | Rules of origin requirements |
| TradeFacilitation | TEXT | NULL | Trade facilitation measures |
| CustomsProcedures | TEXT | NULL | Customs procedure simplifications |
| TechnicalBarriers | TEXT | NULL | Technical barrier provisions |
| SanitaryMeasures | TEXT | NULL | Sanitary and phytosanitary measures |
| GovernmentProcurement | TEXT | NULL | Government procurement access |
| IntellectualProperty | TEXT | NULL | IP protection provisions |
| InvestmentProvisions | TEXT | NULL | Investment protection measures |
| LaborStandards | TEXT | NULL | Labor standard requirements |
| EnvironmentalStandards | TEXT | NULL | Environmental provisions |
| DisputeResolution | TEXT | NULL | Dispute resolution mechanisms |
| MonitoringMechanisms | TEXT | NULL | Implementation monitoring |
| ComplianceRequirements | TEXT | NULL | Compliance obligations |
| CertificationProcedures | TEXT | NULL | Certification requirements |
| DocumentationRequirements | TEXT | NULL | Required documentation |
| ImplementationStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Negotiating' | Status of implementation |
| UtilizationRate | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Agreement utilization rate % |
| EconomicImpact | TEXT | NULL | Economic impact assessment |
| BusinessBenefits | TEXT | NULL | Key business benefits |
| CostSavingsOpportunities | TEXT | NULL | Cost reduction opportunities |
| RiskFactors | TEXT | NULL | Implementation risks |
| SuccessFactors | TEXT | NULL | Critical success factors |
| MonitoringFrequency | VARCHAR(20) | NOT NULL, DEFAULT 'Annual' | Monitoring frequency |
| NextReviewDate | DATE | NULL | Next agreement review |
| RenegotiationTriggers | TEXT | NULL | Renegotiation triggers |
| WithdrawalProvisions | TEXT | NULL | Withdrawal procedures |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active agreement flag |
| IsPreferential | BOOLEAN | NOT NULL, DEFAULT TRUE | Preferential treatment flag |
| DataSources | TEXT | NOT NULL | Information sources |
| LastUpdated | TIMESTAMP | NOT NULL | Last information update |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE TradeAgreement ADD CONSTRAINT PK_TradeAgreement PRIMARY KEY (TradeAgreementId);

-- Unique Constraints
ALTER TABLE TradeAgreement ADD CONSTRAINT UK_TradeAgreement_AgreementCode UNIQUE (AgreementCode);

-- Check Constraints
ALTER TABLE TradeAgreement ADD CONSTRAINT CK_TradeAgreement_AgreementType 
    CHECK (AgreementType IN ('Free Trade Agreement', 'Customs Union', 'Economic Partnership', 
                             'Preferential Trade Agreement', 'Comprehensive Agreement', 'Bilateral Agreement'));
ALTER TABLE TradeAgreement ADD CONSTRAINT CK_TradeAgreement_ImplementationStatus 
    CHECK (ImplementationStatus IN ('Negotiating', 'Signed', 'Ratifying', 'Implemented', 
                                   'Suspended', 'Terminated', 'Renegotiating'));
ALTER TABLE TradeAgreement ADD CONSTRAINT CK_TradeAgreement_MonitoringFrequency 
    CHECK (MonitoringFrequency IN ('Quarterly', 'Semi-Annual', 'Annual', 'Bi-Annual'));

-- Business Rules
ALTER TABLE TradeAgreement ADD CONSTRAINT CK_TradeAgreement_ChronologicalOrder 
    CHECK (RatificationDate IS NULL OR SigningDate IS NULL OR RatificationDate >= SigningDate);
ALTER TABLE TradeAgreement ADD CONSTRAINT CK_TradeAgreement_EffectiveAfterSigning 
    CHECK (SigningDate IS NULL OR EffectiveDate >= SigningDate);
ALTER TABLE TradeAgreement ADD CONSTRAINT CK_TradeAgreement_ExpirationAfterEffective 
    CHECK (ExpirationDate IS NULL OR ExpirationDate > EffectiveDate);
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Status and Date Indexes
CREATE INDEX IX_TradeAgreement_ImplementationStatus ON TradeAgreement(ImplementationStatus);
CREATE INDEX IX_TradeAgreement_EffectiveDate ON TradeAgreement(EffectiveDate DESC);
CREATE INDEX IX_TradeAgreement_ExpirationDate ON TradeAgreement(ExpirationDate);
CREATE INDEX IX_TradeAgreement_NextReviewDate ON TradeAgreement(NextReviewDate);

-- Agreement Classification Indexes
CREATE INDEX IX_TradeAgreement_AgreementType ON TradeAgreement(AgreementType);
CREATE INDEX IX_TradeAgreement_IsActive ON TradeAgreement(IsActive);
CREATE INDEX IX_TradeAgreement_IsPreferential ON TradeAgreement(IsPreferential);

-- Performance Indexes
CREATE INDEX IX_TradeAgreement_UtilizationRate ON TradeAgreement(UtilizationRate DESC);

-- Composite Indexes
CREATE INDEX IX_TradeAgreement_Status_Date ON TradeAgreement(ImplementationStatus, EffectiveDate DESC);
CREATE INDEX IX_TradeAgreement_Active_Type ON TradeAgreement(IsActive, AgreementType);

-- Full-text indexes for content searches
CREATE FULLTEXT INDEX FTI_TradeAgreement_Content ON TradeAgreement(AgreementScope, TariffReductions, BusinessBenefits);
```

---

## Business Rules and Calculations

### Tariff Impact Calculation

```sql
-- Function to calculate tariff impact
CREATE FUNCTION CalculateTariffImpact(
    @AnnualSpend DECIMAL(19,4),
    @CurrentTariffRate DECIMAL(8,4),
    @NewTariffRate DECIMAL(8,4)
)
RETURNS DECIMAL(19,4)
AS
BEGIN
    DECLARE @Impact DECIMAL(19,4);
    DECLARE @RateChange DECIMAL(8,4) = @NewTariffRate - ISNULL(@CurrentTariffRate, 0);
    
    -- Calculate annual cost impact
    SET @Impact = @AnnualSpend * (@RateChange / 100.0);
    
    RETURN @Impact;
END;
```

### Policy Monitoring Alerts

```sql
-- Stored procedure to generate tariff policy alerts
CREATE PROCEDURE GenerateTariffAlerts
AS
BEGIN
    -- Alert for policies requiring review
    INSERT INTO RiskAlertHistory (
        RiskAssessmentId, AlertType, AlertLevel, AlertTitle, AlertDescription, 
        TriggerValue, AlertDate, DetectedBy, Status
    )
    SELECT 
        NULL,
        'Policy Review',
        CASE 
            WHEN DATEDIFF(day, tp.NextReviewDate, GETDATE()) > 30 THEN 'High'
            WHEN DATEDIFF(day, tp.NextReviewDate, GETDATE()) > 0 THEN 'Medium'
            ELSE 'Low'
        END,
        'Tariff Policy Review Required',
        'Policy ' + tp.PolicyName + ' requires scheduled review',
        DATEDIFF(day, tp.NextReviewDate, GETDATE()),
        GETDATE(),
        'System',
        'Open'
    FROM TariffPolicy tp
    WHERE tp.NextReviewDate <= DATEADD(day, 7, GETDATE())
      AND tp.IsActive = 1;
    
    -- Alert for significant rate changes
    INSERT INTO RiskAlertHistory (
        RiskAssessmentId, AlertType, AlertLevel, AlertTitle, AlertDescription,
        TriggerValue, AlertDate, DetectedBy, Status
    )
    SELECT 
        NULL,
        'Rate Change',
        CASE 
            WHEN ABS(trh.PercentageChange) >= 50 THEN 'Critical'
            WHEN ABS(trh.PercentageChange) >= 25 THEN 'High'
            ELSE 'Medium'
        END,
        'Significant Tariff Rate Change',
        'Rate change of ' + CAST(trh.PercentageChange AS VARCHAR(10)) + '% for policy ' + tp.PolicyName,
        ABS(trh.PercentageChange),
        trh.EffectiveDate,
        'System',
        'Open'
    FROM TariffRateHistory trh
    JOIN TariffPolicy tp ON trh.TariffPolicyId = tp.TariffPolicyId
    WHERE trh.EffectiveDate >= DATEADD(day, -7, GETDATE())
      AND ABS(trh.PercentageChange) >= 10;
END;
```

### Trade Agreement Benefits Analysis

```sql
-- Function to calculate potential savings from trade agreements
CREATE FUNCTION CalculateTradeAgreementSavings(
    @AnnualSpend DECIMAL(19,4),
    @StandardTariffRate DECIMAL(8,4),
    @PreferentialRate DECIMAL(8,4)
)
RETURNS DECIMAL(19,4)
AS
BEGIN
    DECLARE @Savings DECIMAL(19,4);
    DECLARE @RateDifference DECIMAL(8,4) = @StandardTariffRate - @PreferentialRate;
    
    IF @RateDifference > 0
        SET @Savings = @AnnualSpend * (@RateDifference / 100.0);
    ELSE
        SET @Savings = 0;
    
    RETURN @Savings;
END;
```

---

## Data Quality Rules

### Tariff Policy Management
- Policy codes must be unique and follow naming conventions
- Effective dates must be logically consistent with announcement dates
- Rate changes must be properly documented with sources
- Impact assessments must be updated when policies change

### Historical Data Integrity
- Rate history must maintain chronological order
- Rate changes must be validated against official sources
- Historical data must be preserved for trending analysis
- Data quality scores must reflect accuracy and completeness

### Trade Agreement Tracking
- Agreement information must be current and verified
- Participating countries must be valid and complete
- Implementation status must be accurately maintained
- Benefits analysis must be regularly updated

---

*Document Version*: 1.0  
*Last Updated*: August 21, 2025  
*Next Review*: September 21, 2025  
*Document Owner*: Trade Policy Team
