# Supplier Relationships - Logical Data Model

## Overview
This document defines the logical structure for supplier capability assessments, performance relationships, and many-to-many associations between suppliers, categories, and geographic regions.

---

## Entity: SupplierCategoryCapability

### Purpose
Many-to-many relationship defining supplier capabilities, qualifications, and performance history by product category.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| CapabilityId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| SupplierId | BIGINT | FK, NOT NULL | Reference to supplier |
| CategoryId | BIGINT | FK, NOT NULL | Reference to product category |
| QualificationStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Unqualified' | Qualification status |
| QualificationDate | DATE | NULL | Date qualified for category |
| LastQualificationReview | DATE | NULL | Last qualification review |
| NextQualificationReview | DATE | NULL | Next scheduled review |
| CapabilityScore | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Overall capability score |
| TechnicalCapabilityScore | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Technical capability |
| QualityCapabilityScore | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Quality management capability |
| CapacityCapabilityScore | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Production capacity capability |
| DeliveryCapabilityScore | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Delivery performance capability |
| CostCompetitivenessScore | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Cost competitiveness |
| InnovationCapabilityScore | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Innovation capability |
| ServiceCapabilityScore | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Service capability |
| ComplianceScore | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Regulatory compliance |
| ESGScore | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Environmental/social/governance |
| ProductionCapacity | DECIMAL(15,2) | NULL, CHECK >= 0 | Maximum production capacity |
| CapacityUnit | VARCHAR(50) | NULL | Capacity measurement unit |
| AvailableCapacity | DECIMAL(15,2) | NULL, CHECK >= 0 | Currently available capacity |
| CapacityUtilization | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Current capacity utilization % |
| LeadTimeStandard | DECIMAL(8,2) | NULL, CHECK >= 0 | Standard lead time in days |
| LeadTimeMinimum | DECIMAL(8,2) | NULL, CHECK >= 0 | Minimum achievable lead time |
| LeadTimeMaximum | DECIMAL(8,2) | NULL, CHECK >= 0 | Maximum lead time |
| MinimumOrderQuantity | DECIMAL(15,2) | NULL, CHECK >= 0 | Minimum order quantity |
| MaximumOrderQuantity | DECIMAL(15,2) | NULL, CHECK >= 0 | Maximum order quantity |
| OrderQuantityUnit | VARCHAR(50) | NULL | Order quantity unit |
| PricingModel | VARCHAR(20) | NULL | Fixed, Variable, Volume-based, etc. |
| CurrencyPreference | VARCHAR(3) | FK, NULL | Preferred pricing currency |
| PaymentTermsPreference | VARCHAR(100) | NULL | Preferred payment terms |
| SupplierTier | VARCHAR(10) | NULL | Tier 1, Tier 2, Tier 3 |
| StrategicImportance | VARCHAR(15) | NOT NULL, DEFAULT 'Standard' | Critical, High, Standard, Low |
| RelationshipType | VARCHAR(20) | NOT NULL, DEFAULT 'Transactional' | Strategic, Partnership, etc. |
| ContractStatus | VARCHAR(20) | NULL | Active, Expired, Negotiating, etc. |
| ContractStartDate | DATE | NULL | Current contract start date |
| ContractEndDate | DATE | NULL | Current contract end date |
| ContractValue | DECIMAL(19,4) | NULL, CHECK >= 0 | Contract value |
| ContractCurrency | VARCHAR(3) | FK, NULL | Contract currency |
| AnnualSpendBudget | DECIMAL(19,4) | NULL, CHECK >= 0 | Budgeted annual spend |
| ActualAnnualSpend | DECIMAL(19,4) | NULL, CHECK >= 0 | Actual annual spend |
| SpendTrend | VARCHAR(15) | NULL | Increasing, Stable, Decreasing |
| MarketShare | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Supplier's market share % |
| CompetitivePosition | VARCHAR(20) | NULL | Market position assessment |
| DevelopmentPriority | VARCHAR(10) | NOT NULL, DEFAULT 'Medium' | Investment priority |
| DevelopmentStage | VARCHAR(20) | NULL | Development stage |
| InvestmentLevel | DECIMAL(15,2) | NULL, CHECK >= 0 | Development investment amount |
| DevelopmentROI | DECIMAL(5,2) | NULL | Development return on investment |
| RiskLevel | VARCHAR(10) | NULL | Low, Medium, High, Critical |
| RiskMitigationPlan | TEXT | NULL | Risk mitigation strategies |
| PerformanceHistory | TEXT | NULL | Historical performance summary |
| KeyStrengths | TEXT | NULL | Supplier key strengths |
| ImprovementAreas | TEXT | NULL | Areas needing improvement |
| CompetitiveAdvantages | TEXT | NULL | Competitive advantages |
| TechnicalSpecialties | TEXT | NULL | Technical specializations |
| GeographicCoverage | TEXT | NULL | Geographic service areas |
| CertificationsHeld | TEXT | NULL | Relevant certifications |
| QualitySystemMaturity | VARCHAR(20) | NULL | Quality system assessment |
| DigitalMaturityLevel | VARCHAR(20) | NULL | Digital capability level |
| InnovationTrackRecord | TEXT | NULL | Innovation history |
| SustainabilityInitiatives | TEXT | NULL | Sustainability programs |
| DiversityStatus | TEXT | NULL | Diversity classifications |
| CollaborationLevel | VARCHAR(20) | NULL | Collaboration engagement |
| CommunicationEffectiveness | VARCHAR(10) | NULL | Communication rating |
| ResponsivenessRating | VARCHAR(10) | NULL | Responsiveness rating |
| FlexibilityRating | VARCHAR(10) | NULL | Flexibility rating |
| ReliabilityRating | VARCHAR(10) | NULL | Reliability rating |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active capability record |
| IsPreferred | BOOLEAN | NOT NULL, DEFAULT FALSE | Preferred supplier flag |
| IsApproved | BOOLEAN | NOT NULL, DEFAULT FALSE | Approved supplier flag |
| IsStrategic | BOOLEAN | NOT NULL, DEFAULT FALSE | Strategic supplier flag |
| RequiresDevelopment | BOOLEAN | NOT NULL, DEFAULT FALSE | Development required flag |
| LastPerformanceReview | DATE | NULL | Last performance review |
| NextPerformanceReview | DATE | NOT NULL | Next scheduled review |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT PK_SupplierCategoryCapability PRIMARY KEY (CapabilityId);

-- Unique Constraint for Supplier-Category pair
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT UK_SupplierCategoryCapability_SupplierCategory 
    UNIQUE (SupplierId, CategoryId);

-- Foreign Keys
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT FK_SupplierCategoryCapability_Supplier 
    FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId) ON DELETE CASCADE;
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT FK_SupplierCategoryCapability_Category 
    FOREIGN KEY (CategoryId) REFERENCES ProductCategory(CategoryId) ON DELETE CASCADE;
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT FK_SupplierCategoryCapability_CurrencyPreference 
    FOREIGN KEY (CurrencyPreference) REFERENCES Currency(CurrencyCode);
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT FK_SupplierCategoryCapability_ContractCurrency 
    FOREIGN KEY (ContractCurrency) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_QualificationStatus 
    CHECK (QualificationStatus IN ('Unqualified', 'Under Review', 'Qualified', 'Preferred', 
                                   'Strategic', 'Disqualified', 'Suspended'));
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_SupplierTier 
    CHECK (SupplierTier IN ('Tier 1', 'Tier 2', 'Tier 3', 'Development') OR SupplierTier IS NULL);
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_StrategicImportance 
    CHECK (StrategicImportance IN ('Critical', 'High', 'Standard', 'Low'));
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_RelationshipType 
    CHECK (RelationshipType IN ('Strategic Partnership', 'Preferred', 'Transactional', 'Development', 'Spot'));
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_ContractStatus 
    CHECK (ContractStatus IN ('Active', 'Expired', 'Negotiating', 'Pending', 'Terminated', 'Suspended') OR ContractStatus IS NULL);
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_SpendTrend 
    CHECK (SpendTrend IN ('Increasing', 'Stable', 'Decreasing', 'Volatile') OR SpendTrend IS NULL);
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_DevelopmentPriority 
    CHECK (DevelopmentPriority IN ('Low', 'Medium', 'High', 'Critical'));
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_RiskLevel 
    CHECK (RiskLevel IN ('Low', 'Medium', 'High', 'Critical') OR RiskLevel IS NULL);

-- Business Rules
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_LeadTimes 
    CHECK (LeadTimeMaximum IS NULL OR LeadTimeMinimum IS NULL OR LeadTimeMaximum >= LeadTimeMinimum);
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_OrderQuantities 
    CHECK (MaximumOrderQuantity IS NULL OR MinimumOrderQuantity IS NULL OR MaximumOrderQuantity >= MinimumOrderQuantity);
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_ContractDates 
    CHECK (ContractEndDate IS NULL OR ContractStartDate IS NULL OR ContractEndDate > ContractStartDate);
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_CapacityLogic 
    CHECK (AvailableCapacity IS NULL OR ProductionCapacity IS NULL OR AvailableCapacity <= ProductionCapacity);
ALTER TABLE SupplierCategoryCapability ADD CONSTRAINT CK_SupplierCategoryCapability_NextReview 
    CHECK (NextPerformanceReview > DATEADD(month, -1, GETDATE()));
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_SupplierCategoryCapability_SupplierId ON SupplierCategoryCapability(SupplierId);
CREATE INDEX IX_SupplierCategoryCapability_CategoryId ON SupplierCategoryCapability(CategoryId);
CREATE INDEX IX_SupplierCategoryCapability_CurrencyPreference ON SupplierCategoryCapability(CurrencyPreference);
CREATE INDEX IX_SupplierCategoryCapability_ContractCurrency ON SupplierCategoryCapability(ContractCurrency);

-- Status and Classification Indexes
CREATE INDEX IX_SupplierCategoryCapability_QualificationStatus ON SupplierCategoryCapability(QualificationStatus);
CREATE INDEX IX_SupplierCategoryCapability_SupplierTier ON SupplierCategoryCapability(SupplierTier);
CREATE INDEX IX_SupplierCategoryCapability_StrategicImportance ON SupplierCategoryCapability(StrategicImportance);
CREATE INDEX IX_SupplierCategoryCapability_RelationshipType ON SupplierCategoryCapability(RelationshipType);

-- Performance and Scoring Indexes
CREATE INDEX IX_SupplierCategoryCapability_CapabilityScore ON SupplierCategoryCapability(CapabilityScore DESC);
CREATE INDEX IX_SupplierCategoryCapability_CostCompetitivenessScore ON SupplierCategoryCapability(CostCompetitivenessScore DESC);
CREATE INDEX IX_SupplierCategoryCapability_QualityCapabilityScore ON SupplierCategoryCapability(QualityCapabilityScore DESC);

-- Financial Indexes
CREATE INDEX IX_SupplierCategoryCapability_ActualAnnualSpend ON SupplierCategoryCapability(ActualAnnualSpend DESC);
CREATE INDEX IX_SupplierCategoryCapability_ContractValue ON SupplierCategoryCapability(ContractValue DESC);

-- Boolean Flag Indexes
CREATE INDEX IX_SupplierCategoryCapability_IsActive ON SupplierCategoryCapability(IsActive);
CREATE INDEX IX_SupplierCategoryCapability_IsPreferred ON SupplierCategoryCapability(IsPreferred);
CREATE INDEX IX_SupplierCategoryCapability_IsStrategic ON SupplierCategoryCapability(IsStrategic);

-- Date-based Indexes
CREATE INDEX IX_SupplierCategoryCapability_NextPerformanceReview ON SupplierCategoryCapability(NextPerformanceReview);
CREATE INDEX IX_SupplierCategoryCapability_ContractEndDate ON SupplierCategoryCapability(ContractEndDate);
CREATE INDEX IX_SupplierCategoryCapability_QualificationDate ON SupplierCategoryCapability(QualificationDate DESC);

-- Composite Indexes for Common Queries
CREATE INDEX IX_SupplierCategoryCapability_Category_Status ON SupplierCategoryCapability(CategoryId, QualificationStatus);
CREATE INDEX IX_SupplierCategoryCapability_Supplier_Active ON SupplierCategoryCapability(SupplierId, IsActive);
CREATE INDEX IX_SupplierCategoryCapability_Strategic_Score ON SupplierCategoryCapability(IsStrategic, CapabilityScore DESC);
CREATE INDEX IX_SupplierCategoryCapability_Active_Tier ON SupplierCategoryCapability(IsActive, SupplierTier);
```

---

## Entity: SupplierPerformanceHistory

### Purpose
Historical performance tracking for suppliers across multiple dimensions and time periods.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| PerformanceId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| SupplierId | BIGINT | FK, NOT NULL | Reference to supplier |
| CategoryId | BIGINT | FK, NULL | Reference to product category (optional) |
| PerformancePeriod | DATE | NOT NULL | Performance period (month-end date) |
| PeriodType | VARCHAR(20) | NOT NULL | Monthly, Quarterly, Annual |
| OverallPerformanceScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Overall performance score |
| QualityScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Quality performance score |
| DeliveryScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Delivery performance score |
| CostScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Cost performance score |
| ServiceScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Service performance score |
| InnovationScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Innovation performance score |
| ResponsivenessScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Responsiveness score |
| ComplianceScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Compliance performance score |
| RelationshipScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Relationship management score |
| TotalOrderCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Total orders placed |
| CompletedOrderCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Orders completed |
| OnTimeOrderCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Orders delivered on time |
| OnTimeDeliveryRate | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | On-time delivery percentage |
| EarlyDeliveryCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Orders delivered early |
| LateDeliveryCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Orders delivered late |
| AverageDelayDays | DECIMAL(8,2) | NULL, CHECK >= 0 | Average delay in days |
| MaximumDelayDays | DECIMAL(8,2) | NULL, CHECK >= 0 | Maximum delay observed |
| QualityAcceptanceRate | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Quality acceptance rate |
| DefectRate | DECIMAL(5,4) | NOT NULL, DEFAULT 0, CHECK 0.0000-100.0000 | Defect rate percentage |
| ReworkRate | DECIMAL(5,4) | NOT NULL, DEFAULT 0, CHECK 0.0000-100.0000 | Rework rate percentage |
| ReturnRate | DECIMAL(5,4) | NOT NULL, DEFAULT 0, CHECK 0.0000-100.0000 | Return rate percentage |
| QualityIncidentCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Number of quality incidents |
| QualityImprovementInitiatives | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Quality improvement projects |
| TotalSpendAmount | DECIMAL(19,4) | NOT NULL, DEFAULT 0, CHECK >= 0 | Total spend amount |
| SpendCurrency | VARCHAR(3) | FK, NOT NULL | Spend currency |
| CostSavingsAchieved | DECIMAL(19,4) | NOT NULL, DEFAULT 0, CHECK >= 0 | Cost savings delivered |
| CostSavingsPercentage | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK >= 0 | Cost savings percentage |
| PriceVarianceAmount | DECIMAL(19,4) | NULL | Price variance (+ or -) |
| PriceVariancePercentage | DECIMAL(5,2) | NULL | Price variance percentage |
| ContractComplianceRate | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Contract compliance rate |
| InvoiceAccuracyRate | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Invoice accuracy rate |
| PaymentTermsCompliance | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Payment terms compliance |
| ResponseTimeHours | DECIMAL(8,2) | NULL, CHECK >= 0 | Average response time in hours |
| ResolutionTimeHours | DECIMAL(8,2) | NULL, CHECK >= 0 | Average issue resolution time |
| CustomerSatisfactionScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Customer satisfaction rating |
| EscalationCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Number of escalations |
| ComplaintCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Number of complaints |
| ComplimentCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Number of compliments |
| InnovationProjectCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Innovation projects count |
| SustainabilityScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Sustainability performance |
| ESGComplianceRate | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | ESG compliance rate |
| RiskIncidentCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Risk incidents count |
| BusinessContinuityScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Business continuity rating |
| DigitalCapabilityScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Digital capability assessment |
| CollaborationEffectiveness | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Collaboration effectiveness |
| TrendDirection | VARCHAR(15) | NULL | Improving, Stable, Deteriorating |
| PerformanceRank | INT | NULL, CHECK > 0 | Rank among category suppliers |
| BenchmarkComparison | VARCHAR(20) | NULL | Above, At, Below benchmark |
| KeyAchievements | TEXT | NULL | Notable achievements |
| ImprovementAreas | TEXT | NULL | Areas needing improvement |
| ActionItemsOpen | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Open action items |
| ActionItemsClosed | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Closed action items |
| PerformanceNotes | TEXT | NULL | Performance period notes |
| DataQualityScore | DECIMAL(5,2) | NOT NULL, DEFAULT 100, CHECK 0.00-100.00 | Data completeness score |
| CalculationMethod | VARCHAR(50) | NOT NULL | Calculation methodology |
| DataSources | TEXT | NOT NULL | Data source references |
| LastCalculatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last calculation timestamp |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |

### Constraints

```sql
-- Primary Key
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT PK_SupplierPerformanceHistory PRIMARY KEY (PerformanceId);

-- Unique Constraint for Supplier-Category-Period combination
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT UK_SupplierPerformanceHistory_SupplierPeriod 
    UNIQUE (SupplierId, CategoryId, PerformancePeriod, PeriodType);

-- Foreign Keys
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT FK_SupplierPerformanceHistory_Supplier 
    FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId) ON DELETE CASCADE;
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT FK_SupplierPerformanceHistory_Category 
    FOREIGN KEY (CategoryId) REFERENCES ProductCategory(CategoryId) ON DELETE SET NULL;
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT FK_SupplierPerformanceHistory_Currency 
    FOREIGN KEY (SpendCurrency) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT CK_SupplierPerformanceHistory_PeriodType 
    CHECK (PeriodType IN ('Monthly', 'Quarterly', 'Semi-Annual', 'Annual', 'YTD'));
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT CK_SupplierPerformanceHistory_TrendDirection 
    CHECK (TrendDirection IN ('Improving', 'Stable', 'Deteriorating', 'Volatile') OR TrendDirection IS NULL);
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT CK_SupplierPerformanceHistory_BenchmarkComparison 
    CHECK (BenchmarkComparison IN ('Well Above', 'Above', 'At', 'Below', 'Well Below') OR BenchmarkComparison IS NULL);
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT CK_SupplierPerformanceHistory_CalculationMethod 
    CHECK (CalculationMethod IN ('Automated', 'Semi-Automated', 'Manual', 'System-Generated'));

-- Business Rules
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT CK_SupplierPerformanceHistory_OrderCounts 
    CHECK (CompletedOrderCount <= TotalOrderCount);
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT CK_SupplierPerformanceHistory_OnTimeOrders 
    CHECK (OnTimeOrderCount <= CompletedOrderCount);
ALTER TABLE SupplierPerformanceHistory ADD CONSTRAINT CK_SupplierPerformanceHistory_DeliveryBreakdown 
    CHECK ((EarlyDeliveryCount + OnTimeOrderCount + LateDeliveryCount) <= CompletedOrderCount);
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_SupplierPerformanceHistory_SupplierId ON SupplierPerformanceHistory(SupplierId);
CREATE INDEX IX_SupplierPerformanceHistory_CategoryId ON SupplierPerformanceHistory(CategoryId);
CREATE INDEX IX_SupplierPerformanceHistory_SpendCurrency ON SupplierPerformanceHistory(SpendCurrency);

-- Date and Period Indexes
CREATE INDEX IX_SupplierPerformanceHistory_PerformancePeriod ON SupplierPerformanceHistory(PerformancePeriod DESC);
CREATE INDEX IX_SupplierPerformanceHistory_PeriodType ON SupplierPerformanceHistory(PeriodType);

-- Performance Score Indexes
CREATE INDEX IX_SupplierPerformanceHistory_OverallScore ON SupplierPerformanceHistory(OverallPerformanceScore DESC);
CREATE INDEX IX_SupplierPerformanceHistory_QualityScore ON SupplierPerformanceHistory(QualityScore DESC);
CREATE INDEX IX_SupplierPerformanceHistory_DeliveryScore ON SupplierPerformanceHistory(DeliveryScore DESC);
CREATE INDEX IX_SupplierPerformanceHistory_CostScore ON SupplierPerformanceHistory(CostScore DESC);

-- Performance Metrics Indexes
CREATE INDEX IX_SupplierPerformanceHistory_OnTimeDeliveryRate ON SupplierPerformanceHistory(OnTimeDeliveryRate DESC);
CREATE INDEX IX_SupplierPerformanceHistory_DefectRate ON SupplierPerformanceHistory(DefectRate);
CREATE INDEX IX_SupplierPerformanceHistory_TotalSpend ON SupplierPerformanceHistory(TotalSpendAmount DESC);

-- Analysis Indexes
CREATE INDEX IX_SupplierPerformanceHistory_TrendDirection ON SupplierPerformanceHistory(TrendDirection);
CREATE INDEX IX_SupplierPerformanceHistory_PerformanceRank ON SupplierPerformanceHistory(PerformanceRank);

-- Composite Indexes for Common Queries
CREATE INDEX IX_SupplierPerformanceHistory_Supplier_Period ON SupplierPerformanceHistory(SupplierId, PerformancePeriod DESC);
CREATE INDEX IX_SupplierPerformanceHistory_Category_Score ON SupplierPerformanceHistory(CategoryId, OverallPerformanceScore DESC);
CREATE INDEX IX_SupplierPerformanceHistory_Period_Rank ON SupplierPerformanceHistory(PerformancePeriod DESC, PerformanceRank);

-- Partitioning by PerformancePeriod (monthly partitions for performance)
```

---

## Entity: SupplierGeographicPresence

### Purpose
Many-to-many relationship tracking supplier presence and capabilities across geographic regions.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| PresenceId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| SupplierId | BIGINT | FK, NOT NULL | Reference to supplier |
| GeographicRegionId | BIGINT | FK, NOT NULL | Reference to geographic region |
| PresenceType | VARCHAR(20) | NOT NULL | Headquarters, Manufacturing, etc. |
| LocationName | VARCHAR(255) | NULL | Specific location name |
| EstablishedDate | DATE | NULL | When presence was established |
| OperationalStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Active' | Operational status |
| EmployeeCount | INT | NULL, CHECK >= 0 | Employee count at location |
| InvestmentAmount | DECIMAL(19,4) | NULL, CHECK >= 0 | Investment in location |
| InvestmentCurrency | VARCHAR(3) | FK, NULL | Investment currency |
| ProductionCapacity | DECIMAL(15,2) | NULL, CHECK >= 0 | Production capacity |
| CapacityUnit | VARCHAR(50) | NULL | Capacity measurement unit |
| CapacityUtilization | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Current utilization % |
| TechnologyLevel | VARCHAR(20) | NULL | Technology sophistication |
| QualityCertifications | TEXT | NULL | Location-specific certifications |
| EnvironmentalCertifications | TEXT | NULL | Environmental certifications |
| LocalSupplyChainIntegration | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Local supplier integration % |
| LocalContentPercentage | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Local content percentage |
| ExportCapability | BOOLEAN | NOT NULL, DEFAULT FALSE | Export capability flag |
| ImportCapability | BOOLEAN | NOT NULL, DEFAULT FALSE | Import capability flag |
| LogisticsCapability | TEXT | NULL | Logistics capabilities |
| CustomsCapability | TEXT | NULL | Customs processing capability |
| LanguageCapabilities | VARCHAR(255) | NULL | Languages supported |
| CulturalCapabilities | TEXT | NULL | Cultural competencies |
| RegulatoryCompliance | TEXT | NULL | Local regulatory compliance |
| TaxOptimization | TEXT | NULL | Tax optimization capabilities |
| LegalStructure | VARCHAR(100) | NULL | Legal entity structure |
| LocalPartnership | TEXT | NULL | Local partnerships |
| GovernmentRelations | TEXT | NULL | Government relationship status |
| CommunityEngagement | TEXT | NULL | Community engagement activities |
| SustainabilityInitiatives | TEXT | NULL | Local sustainability programs |
| RiskFactors | TEXT | NULL | Location-specific risks |
| PoliticalRiskLevel | VARCHAR(10) | NULL | Political risk assessment |
| EconomicRiskLevel | VARCHAR(10) | NULL | Economic risk assessment |
| OperationalRiskLevel | VARCHAR(10) | NULL | Operational risk assessment |
| NaturalDisasterRisk | VARCHAR(10) | NULL | Natural disaster risk level |
| SecurityRiskLevel | VARCHAR(10) | NULL | Security risk assessment |
| ComplianceRiskLevel | VARCHAR(10) | NULL | Compliance risk level |
| OverallRiskScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Overall location risk score |
| CompetitiveAdvantages | TEXT | NULL | Location competitive advantages |
| MarketAccess | TEXT | NULL | Market access benefits |
| CostAdvantages | TEXT | NULL | Cost advantages |
| SkillAvailability | TEXT | NULL | Local skill availability |
| InfrastructureQuality | VARCHAR(10) | NULL | Infrastructure assessment |
| BusinessClimate | VARCHAR(10) | NULL | Business climate rating |
| InnovationEcosystem | TEXT | NULL | Innovation ecosystem access |
| SupplyChainResilience | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Supply chain resilience score |
| BusinessContinuityPlans | TEXT | NULL | Business continuity planning |
| ExpansionPlans | TEXT | NULL | Future expansion plans |
| InvestmentPlans | TEXT | NULL | Planned investments |
| CapacityExpansionPlans | TEXT | NULL | Capacity expansion plans |
| StrategicImportance | VARCHAR(15) | NOT NULL, DEFAULT 'Standard' | Strategic importance level |
| PerformanceRating | VARCHAR(10) | NULL | Performance rating |
| DevelopmentPotential | VARCHAR(10) | NULL | Development potential |
| MonitoringFrequency | VARCHAR(20) | NOT NULL, DEFAULT 'Quarterly' | Monitoring frequency |
| LastAssessmentDate | DATE | NULL | Last assessment date |
| NextAssessmentDate | DATE | NULL | Next scheduled assessment |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active presence flag |
| IsStrategic | BOOLEAN | NOT NULL, DEFAULT FALSE | Strategic location flag |
| IsPreferred | BOOLEAN | NOT NULL, DEFAULT FALSE | Preferred location flag |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE SupplierGeographicPresence ADD CONSTRAINT PK_SupplierGeographicPresence PRIMARY KEY (PresenceId);

-- Unique Constraint for Supplier-Region-Type combination
ALTER TABLE SupplierGeographicPresence ADD CONSTRAINT UK_SupplierGeographicPresence_SupplierRegionType 
    UNIQUE (SupplierId, GeographicRegionId, PresenceType);

-- Foreign Keys
ALTER TABLE SupplierGeographicPresence ADD CONSTRAINT FK_SupplierGeographicPresence_Supplier 
    FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId) ON DELETE CASCADE;
ALTER TABLE SupplierGeographicPresence ADD CONSTRAINT FK_SupplierGeographicPresence_GeographicRegion 
    FOREIGN KEY (GeographicRegionId) REFERENCES GeographicRegion(RegionId);
ALTER TABLE SupplierGeographicPresence ADD CONSTRAINT FK_SupplierGeographicPresence_Currency 
    FOREIGN KEY (InvestmentCurrency) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE SupplierGeographicPresence ADD CONSTRAINT CK_SupplierGeographicPresence_PresenceType 
    CHECK (PresenceType IN ('Headquarters', 'Manufacturing', 'R&D', 'Distribution', 'Sales Office', 
                           'Service Center', 'Warehouse', 'Assembly', 'Joint Venture', 'Partnership'));
ALTER TABLE SupplierGeographicPresence ADD CONSTRAINT CK_SupplierGeographicPresence_OperationalStatus 
    CHECK (OperationalStatus IN ('Active', 'Inactive', 'Under Construction', 'Planning', 
                                'Suspended', 'Closing', 'Expanding'));
ALTER TABLE SupplierGeographicPresence ADD CONSTRAINT CK_SupplierGeographicPresence_TechnologyLevel 
    CHECK (TechnologyLevel IN ('Basic', 'Standard', 'Advanced', 'Cutting-edge') OR TechnologyLevel IS NULL);
ALTER TABLE SupplierGeographicPresence ADD CONSTRAINT CK_SupplierGeographicPresence_RiskLevels 
    CHECK (PoliticalRiskLevel IN ('Low', 'Medium', 'High', 'Critical') OR PoliticalRiskLevel IS NULL);
ALTER TABLE SupplierGeographicPresence ADD CONSTRAINT CK_SupplierGeographicPresence_StrategicImportance 
    CHECK (StrategicImportance IN ('Critical', 'High', 'Standard', 'Low'));
ALTER TABLE SupplierGeographicPresence ADD CONSTRAINT CK_SupplierGeographicPresence_MonitoringFrequency 
    CHECK (MonitoringFrequency IN ('Monthly', 'Quarterly', 'Semi-Annual', 'Annual'));
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_SupplierGeographicPresence_SupplierId ON SupplierGeographicPresence(SupplierId);
CREATE INDEX IX_SupplierGeographicPresence_GeographicRegionId ON SupplierGeographicPresence(GeographicRegionId);
CREATE INDEX IX_SupplierGeographicPresence_InvestmentCurrency ON SupplierGeographicPresence(InvestmentCurrency);

-- Classification Indexes
CREATE INDEX IX_SupplierGeographicPresence_PresenceType ON SupplierGeographicPresence(PresenceType);
CREATE INDEX IX_SupplierGeographicPresence_OperationalStatus ON SupplierGeographicPresence(OperationalStatus);
CREATE INDEX IX_SupplierGeographicPresence_StrategicImportance ON SupplierGeographicPresence(StrategicImportance);

-- Risk Assessment Indexes
CREATE INDEX IX_SupplierGeographicPresence_OverallRiskScore ON SupplierGeographicPresence(OverallRiskScore DESC);
CREATE INDEX IX_SupplierGeographicPresence_PoliticalRiskLevel ON SupplierGeographicPresence(PoliticalRiskLevel);

-- Capacity and Performance Indexes
CREATE INDEX IX_SupplierGeographicPresence_ProductionCapacity ON SupplierGeographicPresence(ProductionCapacity DESC);
CREATE INDEX IX_SupplierGeographicPresence_EmployeeCount ON SupplierGeographicPresence(EmployeeCount DESC);
CREATE INDEX IX_SupplierGeographicPresence_InvestmentAmount ON SupplierGeographicPresence(InvestmentAmount DESC);

-- Boolean Flag Indexes
CREATE INDEX IX_SupplierGeographicPresence_IsActive ON SupplierGeographicPresence(IsActive);
CREATE INDEX IX_SupplierGeographicPresence_IsStrategic ON SupplierGeographicPresence(IsStrategic);
CREATE INDEX IX_SupplierGeographicPresence_ExportCapability ON SupplierGeographicPresence(ExportCapability);

-- Date-based Indexes
CREATE INDEX IX_SupplierGeographicPresence_EstablishedDate ON SupplierGeographicPresence(EstablishedDate DESC);
CREATE INDEX IX_SupplierGeographicPresence_NextAssessmentDate ON SupplierGeographicPresence(NextAssessmentDate);

-- Composite Indexes
CREATE INDEX IX_SupplierGeographicPresence_Supplier_Active ON SupplierGeographicPresence(SupplierId, IsActive);
CREATE INDEX IX_SupplierGeographicPresence_Region_Type ON SupplierGeographicPresence(GeographicRegionId, PresenceType);
CREATE INDEX IX_SupplierGeographicPresence_Strategic_Risk ON SupplierGeographicPresence(IsStrategic, OverallRiskScore);
```

---

## Business Rules and Calculations

### Capability Score Calculation

```sql
-- Function to calculate overall capability score
CREATE FUNCTION CalculateSupplierCapabilityScore(
    @TechnicalScore DECIMAL(5,2),
    @QualityScore DECIMAL(5,2),
    @CapacityScore DECIMAL(5,2),
    @DeliveryScore DECIMAL(5,2),
    @CostScore DECIMAL(5,2),
    @InnovationScore DECIMAL(5,2),
    @ServiceScore DECIMAL(5,2),
    @ComplianceScore DECIMAL(5,2),
    @ESGScore DECIMAL(5,2)
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @OverallScore DECIMAL(5,2);
    
    -- Weighted calculation based on category importance
    SELECT @OverallScore = (
        (@TechnicalScore * 0.20) +
        (@QualityScore * 0.20) +
        (@CapacityScore * 0.15) +
        (@DeliveryScore * 0.15) +
        (@CostScore * 0.10) +
        (@InnovationScore * 0.05) +
        (@ServiceScore * 0.05) +
        (@ComplianceScore * 0.05) +
        (@ESGScore * 0.05)
    );
    
    RETURN @OverallScore;
END;
```

### Performance Trend Analysis

```sql
-- Stored procedure to analyze supplier performance trends
CREATE PROCEDURE AnalyzeSupplierPerformanceTrend(
    @SupplierId BIGINT,
    @CategoryId BIGINT = NULL,
    @PeriodCount INT = 6
)
AS
BEGIN
    WITH PerformanceData AS (
        SELECT 
            PerformancePeriod,
            OverallPerformanceScore,
            LAG(OverallPerformanceScore, 1) OVER (ORDER BY PerformancePeriod) AS PreviousScore,
            ROW_NUMBER() OVER (ORDER BY PerformancePeriod DESC) AS RowNum
        FROM SupplierPerformanceHistory
        WHERE SupplierId = @SupplierId
          AND (@CategoryId IS NULL OR CategoryId = @CategoryId)
          AND PeriodType = 'Monthly'
    )
    SELECT 
        pd.*,
        CASE 
            WHEN PreviousScore IS NULL THEN 'Insufficient Data'
            WHEN (OverallPerformanceScore - PreviousScore) > 5 THEN 'Improving'
            WHEN (OverallPerformanceScore - PreviousScore) < -5 THEN 'Deteriorating'
            ELSE 'Stable'
        END AS TrendDirection,
        AVG(OverallPerformanceScore) OVER (ORDER BY PerformancePeriod ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAverage
    FROM PerformanceData pd
    WHERE RowNum <= @PeriodCount
    ORDER BY PerformancePeriod DESC;
END;
```

### Supplier Risk Consolidation

```sql
-- Function to consolidate supplier risks across all relationships
CREATE FUNCTION ConsolidateSupplierRisk(@SupplierId BIGINT)
RETURNS TABLE
AS
RETURN (
    SELECT 
        s.SupplierId,
        s.LegalName,
        AVG(CAST(scc.RiskLevel AS DECIMAL)) AS AverageRiskLevel,
        COUNT(CASE WHEN scc.RiskLevel = 'High' OR scc.RiskLevel = 'Critical' THEN 1 END) AS HighRiskCategories,
        COUNT(CASE WHEN sgp.OverallRiskScore > 70 THEN 1 END) AS HighRiskLocations,
        MAX(ra.OverallRiskScore) AS MaxRiskAssessmentScore
    FROM Supplier s
    LEFT JOIN SupplierCategoryCapability scc ON s.SupplierId = scc.SupplierId AND scc.IsActive = 1
    LEFT JOIN SupplierGeographicPresence sgp ON s.SupplierId = sgp.SupplierId AND sgp.IsActive = 1
    LEFT JOIN RiskAssessment ra ON s.SupplierId = ra.SupplierId 
        AND ra.Status = 'Approved' 
        AND ra.AssessmentDate = (
            SELECT MAX(AssessmentDate) 
            FROM RiskAssessment ra2 
            WHERE ra2.SupplierId = s.SupplierId AND ra2.Status = 'Approved'
        )
    WHERE s.SupplierId = @SupplierId
    GROUP BY s.SupplierId, s.LegalName
);
```

---

## Data Quality Rules

### Supplier Capability Management
- Each supplier-category relationship must have regular performance reviews
- Capability scores must be updated at least annually
- Qualification status changes must be documented with reasons
- Contract information must be kept current and accurate

### Performance History Tracking
- Performance metrics must be calculated using consistent methodologies
- Historical data must be preserved for trend analysis
- Data quality scores must reflect completeness and accuracy
- Performance rankings must be updated regularly

### Geographic Presence Management
- Location information must be verified and current
- Risk assessments must be updated based on changing conditions
- Investment and capacity data must be validated
- Strategic importance classifications must be reviewed periodically

---

*Document Version*: 1.0  
*Last Updated*: August 21, 2025  
*Next Review*: September 21, 2025  
*Document Owner*: Supplier Management Team
