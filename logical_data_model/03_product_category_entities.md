# Product Category Entities - Logical Data Model

## Overview
This document defines the logical structure for product category management, sourcing strategies, and category-based performance tracking.

---

## Entity: ProductCategory

### Purpose
Hierarchical product classification system supporting strategic sourcing and category management activities.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| CategoryId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| CategoryCode | VARCHAR(20) | UK, NOT NULL | Business category identifier |
| CategoryName | VARCHAR(255) | NOT NULL | Category display name |
| CategoryDescription | TEXT | NULL | Detailed category description |
| ParentCategoryId | BIGINT | FK, NULL | Reference to parent category |
| CategoryLevel | INT | NOT NULL, DEFAULT 1 | Hierarchy level (1=top level) |
| CategoryPath | VARCHAR(1000) | NOT NULL | Full hierarchical path |
| CategoryManagerUserId | VARCHAR(50) | FK, NOT NULL | Assigned category manager |
| BackupManagerUserId | VARCHAR(50) | FK, NULL | Backup category manager |
| IndustryCode | VARCHAR(10) | FK, NULL | Related industry classification |
| CommodityCode | VARCHAR(20) | NULL | Commodity classification code |
| UNSPSCCode | VARCHAR(20) | NULL | UN Standard Products and Services Code |
| NAICSCode | VARCHAR(10) | NULL | North American Industry Classification |
| SpendVolume | DECIMAL(19,4) | NULL, CHECK >= 0 | Annual spend volume |
| SpendCurrencyCode | VARCHAR(3) | FK, NULL | Currency for spend amounts |
| StrategicImportance | VARCHAR(15) | NOT NULL, DEFAULT 'Standard' | Critical, High, Standard, Low |
| SourcingStrategy | VARCHAR(20) | NOT NULL, DEFAULT 'Multiple' | Single, Dual, Multiple, Global |
| SupplierConcentrationLimit | DECIMAL(5,2) | NOT NULL, DEFAULT 60.00, CHECK 0.00-100.00 | Max % from single supplier |
| GeographicDiversificationTarget | DECIMAL(5,2) | NOT NULL, DEFAULT 30.00, CHECK 0.00-100.00 | Min % from different regions |
| MinimumSuppliersRequired | INT | NOT NULL, DEFAULT 2, CHECK >= 1 | Minimum qualified suppliers |
| MaximumSuppliersDesired | INT | NULL, CHECK > 0 | Maximum active suppliers |
| QualityRequirementLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Standard' | Basic, Standard, Advanced, Critical |
| ComplianceRequirements | TEXT | NULL | Regulatory compliance requirements |
| TechnicalSpecifications | TEXT | NULL | Technical requirements |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active category flag |
| IsStrategic | BOOLEAN | NOT NULL, DEFAULT FALSE | Strategic category flag |
| RequiresDualSourcing | BOOLEAN | NOT NULL, DEFAULT FALSE | Dual sourcing requirement |
| RequiresLocalSourcing | BOOLEAN | NOT NULL, DEFAULT FALSE | Local sourcing requirement |
| HasRiskMitigation | BOOLEAN | NOT NULL, DEFAULT FALSE | Special risk mitigation required |
| LastReviewDate | DATE | NULL | Last strategy review date |
| NextReviewDate | DATE | NOT NULL | Next scheduled review |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE ProductCategory ADD CONSTRAINT PK_ProductCategory PRIMARY KEY (CategoryId);

-- Unique Constraints
ALTER TABLE ProductCategory ADD CONSTRAINT UK_ProductCategory_CategoryCode UNIQUE (CategoryCode);

-- Foreign Keys
ALTER TABLE ProductCategory ADD CONSTRAINT FK_ProductCategory_ParentCategory 
    FOREIGN KEY (ParentCategoryId) REFERENCES ProductCategory(CategoryId);
ALTER TABLE ProductCategory ADD CONSTRAINT FK_ProductCategory_CategoryManager 
    FOREIGN KEY (CategoryManagerUserId) REFERENCES UserProfile(UserId);
ALTER TABLE ProductCategory ADD CONSTRAINT FK_ProductCategory_BackupManager 
    FOREIGN KEY (BackupManagerUserId) REFERENCES UserProfile(UserId);
ALTER TABLE ProductCategory ADD CONSTRAINT FK_ProductCategory_SpendCurrency 
    FOREIGN KEY (SpendCurrencyCode) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE ProductCategory ADD CONSTRAINT CK_ProductCategory_StrategicImportance 
    CHECK (StrategicImportance IN ('Critical', 'High', 'Standard', 'Low'));
ALTER TABLE ProductCategory ADD CONSTRAINT CK_ProductCategory_SourcingStrategy 
    CHECK (SourcingStrategy IN ('Single', 'Dual', 'Multiple', 'Global', 'Regional', 'Local'));
ALTER TABLE ProductCategory ADD CONSTRAINT CK_ProductCategory_QualityRequirement 
    CHECK (QualityRequirementLevel IN ('Basic', 'Standard', 'Advanced', 'Critical'));

-- Business Rules
ALTER TABLE ProductCategory ADD CONSTRAINT CK_ProductCategory_CategoryLevel 
    CHECK (CategoryLevel >= 1 AND CategoryLevel <= 10);
ALTER TABLE ProductCategory ADD CONSTRAINT CK_ProductCategory_NextReviewDate 
    CHECK (NextReviewDate > LastReviewDate OR LastReviewDate IS NULL);
ALTER TABLE ProductCategory ADD CONSTRAINT CK_ProductCategory_SupplierLimits 
    CHECK (MaximumSuppliersDesired IS NULL OR MaximumSuppliersDesired >= MinimumSuppliersRequired);

-- Hierarchical Constraints (prevent circular references)
-- Implemented via stored procedures and triggers
```

### Indexes

```sql
-- Unique Key Indexes (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_ProductCategory_ParentCategoryId ON ProductCategory(ParentCategoryId);
CREATE INDEX IX_ProductCategory_CategoryManagerUserId ON ProductCategory(CategoryManagerUserId);
CREATE INDEX IX_ProductCategory_BackupManagerUserId ON ProductCategory(BackupManagerUserId);
CREATE INDEX IX_ProductCategory_SpendCurrencyCode ON ProductCategory(SpendCurrencyCode);

-- Hierarchy Navigation Indexes
CREATE INDEX IX_ProductCategory_CategoryLevel ON ProductCategory(CategoryLevel);
CREATE INDEX IX_ProductCategory_CategoryPath ON ProductCategory(CategoryPath);

-- Strategy and Performance Indexes
CREATE INDEX IX_ProductCategory_StrategicImportance ON ProductCategory(StrategicImportance);
CREATE INDEX IX_ProductCategory_SourcingStrategy ON ProductCategory(SourcingStrategy);
CREATE INDEX IX_ProductCategory_IsStrategic ON ProductCategory(IsStrategic);
CREATE INDEX IX_ProductCategory_IsActive ON ProductCategory(IsActive);

-- Spend and Review Indexes
CREATE INDEX IX_ProductCategory_SpendVolume ON ProductCategory(SpendVolume DESC);
CREATE INDEX IX_ProductCategory_NextReviewDate ON ProductCategory(NextReviewDate);

-- Composite Indexes for Common Queries
CREATE INDEX IX_ProductCategory_Active_Strategic ON ProductCategory(IsActive, IsStrategic);
CREATE INDEX IX_ProductCategory_Manager_Active ON ProductCategory(CategoryManagerUserId, IsActive);
CREATE INDEX IX_ProductCategory_Level_Parent ON ProductCategory(CategoryLevel, ParentCategoryId);
```

---

## Entity: CategorySourcingStrategy

### Purpose
Detailed sourcing strategy configurations and targets for product categories.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| StrategyId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| CategoryId | BIGINT | FK, NOT NULL | Reference to product category |
| StrategyName | VARCHAR(255) | NOT NULL | Strategy name/version |
| StrategyDescription | TEXT | NOT NULL | Detailed strategy description |
| EffectiveDate | DATE | NOT NULL | Strategy effective start date |
| ExpirationDate | DATE | NULL | Strategy expiration date |
| StrategicObjectives | TEXT | NOT NULL | Key strategic objectives |
| CostSavingsTarget | DECIMAL(15,2) | NULL, CHECK >= 0 | Annual cost savings target |
| CostSavingsCurrency | VARCHAR(3) | FK, NULL | Currency for cost targets |
| QualityImprovementTarget | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Quality improvement % target |
| DeliveryImprovementTarget | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Delivery improvement % target |
| InnovationTarget | VARCHAR(255) | NULL | Innovation objectives |
| RiskReductionTarget | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Risk reduction % target |
| SupplierDiversificationTarget | INT | NULL, CHECK > 0 | Target number of suppliers |
| GeographicDistributionStrategy | TEXT | NULL | Geographic sourcing strategy |
| TechnologyRequirements | TEXT | NULL | Technology capability requirements |
| ESGRequirements | TEXT | NULL | Environmental/social/governance requirements |
| ComplianceRequirements | TEXT | NULL | Regulatory compliance requirements |
| ContractTermsStrategy | TEXT | NULL | Preferred contract terms |
| PaymentTermsStrategy | VARCHAR(255) | NULL | Preferred payment terms |
| VolumeLeverageStrategy | TEXT | NULL | Volume leveraging approach |
| CompetitivePositioning | TEXT | NULL | Market positioning strategy |
| SupplierDevelopmentPriority | VARCHAR(10) | NOT NULL, DEFAULT 'Medium' | Development investment priority |
| MarketAnalysisRequired | BOOLEAN | NOT NULL, DEFAULT TRUE | Market analysis requirement |
| BenchmarkingRequired | BOOLEAN | NOT NULL, DEFAULT TRUE | Competitive benchmarking requirement |
| TCOAnalysisRequired | BOOLEAN | NOT NULL, DEFAULT TRUE | Total cost of ownership analysis |
| Status | VARCHAR(15) | NOT NULL, DEFAULT 'Draft' | Draft, Active, Superseded, Archived |
| ApprovedBy | VARCHAR(100) | NULL | Strategy approver |
| ApprovedDate | TIMESTAMP | NULL | Strategy approval date |
| ReviewFrequency | VARCHAR(20) | NOT NULL, DEFAULT 'Annual' | Review frequency |
| NextReviewDate | DATE | NOT NULL | Next strategy review date |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE CategorySourcingStrategy ADD CONSTRAINT PK_CategorySourcingStrategy PRIMARY KEY (StrategyId);

-- Foreign Keys
ALTER TABLE CategorySourcingStrategy ADD CONSTRAINT FK_CategorySourcingStrategy_Category 
    FOREIGN KEY (CategoryId) REFERENCES ProductCategory(CategoryId) ON DELETE CASCADE;
ALTER TABLE CategorySourcingStrategy ADD CONSTRAINT FK_CategorySourcingStrategy_Currency 
    FOREIGN KEY (CostSavingsCurrency) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE CategorySourcingStrategy ADD CONSTRAINT CK_CategorySourcingStrategy_SupplierDevelopmentPriority 
    CHECK (SupplierDevelopmentPriority IN ('Low', 'Medium', 'High', 'Critical'));
ALTER TABLE CategorySourcingStrategy ADD CONSTRAINT CK_CategorySourcingStrategy_Status 
    CHECK (Status IN ('Draft', 'Active', 'Superseded', 'Archived'));
ALTER TABLE CategorySourcingStrategy ADD CONSTRAINT CK_CategorySourcingStrategy_ReviewFrequency 
    CHECK (ReviewFrequency IN ('Quarterly', 'Semi-Annual', 'Annual', 'Bi-Annual'));

-- Business Rules
ALTER TABLE CategorySourcingStrategy ADD CONSTRAINT CK_CategorySourcingStrategy_EffectiveDates 
    CHECK (ExpirationDate IS NULL OR ExpirationDate > EffectiveDate);
ALTER TABLE CategorySourcingStrategy ADD CONSTRAINT CK_CategorySourcingStrategy_ApprovalDate 
    CHECK (ApprovedDate IS NULL OR ApprovedDate >= EffectiveDate);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_CategorySourcingStrategy_CategoryId ON CategorySourcingStrategy(CategoryId);
CREATE INDEX IX_CategorySourcingStrategy_CostSavingsCurrency ON CategorySourcingStrategy(CostSavingsCurrency);

-- Status and Date Indexes
CREATE INDEX IX_CategorySourcingStrategy_Status ON CategorySourcingStrategy(Status);
CREATE INDEX IX_CategorySourcingStrategy_EffectiveDate ON CategorySourcingStrategy(EffectiveDate);
CREATE INDEX IX_CategorySourcingStrategy_NextReviewDate ON CategorySourcingStrategy(NextReviewDate);

-- Composite Indexes
CREATE INDEX IX_CategorySourcingStrategy_Category_Status ON CategorySourcingStrategy(CategoryId, Status);
CREATE INDEX IX_CategorySourcingStrategy_Status_Review ON CategorySourcingStrategy(Status, NextReviewDate);
```

---

## Entity: CategoryPerformanceMetrics

### Purpose
Tracks category-level performance metrics and KPIs for sourcing effectiveness measurement.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| MetricId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| CategoryId | BIGINT | FK, NOT NULL | Reference to product category |
| MetricPeriod | DATE | NOT NULL | Reporting period (month-end date) |
| MetricType | VARCHAR(20) | NOT NULL | Monthly, Quarterly, Annual |
| TotalSpend | DECIMAL(19,4) | NOT NULL, DEFAULT 0, CHECK >= 0 | Total category spend |
| SpendCurrencyCode | VARCHAR(3) | FK, NOT NULL | Spend currency |
| NumberOfSuppliers | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Active suppliers count |
| NumberOfPOLines | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Purchase order lines |
| AverageUnitCost | DECIMAL(19,4) | NULL, CHECK >= 0 | Average unit cost |
| CostSavingsAchieved | DECIMAL(19,4) | NOT NULL, DEFAULT 0 | Cost savings delivered |
| CostSavingsPercentage | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK >= 0 | Savings as % of spend |
| AverageQualityScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Average supplier quality score |
| QualityDefectRate | DECIMAL(5,4) | NULL, CHECK 0.0000-100.0000 | Quality defect rate % |
| OnTimeDeliveryRate | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | On-time delivery % |
| AverageLeadTime | DECIMAL(8,2) | NULL, CHECK >= 0 | Average lead time in days |
| SupplierConcentrationRatio | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Top supplier spend % |
| GeographicDiversificationRatio | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Geographic distribution % |
| ContractComplianceRate | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Contract compliance % |
| InvoiceAccuracyRate | DECIMAL(5,2) | NOT NULL, DEFAULT 0, CHECK 0.00-100.00 | Invoice accuracy % |
| AverageRiskScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Average supplier risk score |
| HighRiskSupplierCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Count of high-risk suppliers |
| ESGComplianceRate | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | ESG compliance rate % |
| InnovationProjectCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Innovation projects count |
| SupplierDevelopmentInvestment | DECIMAL(15,2) | NULL, CHECK >= 0 | Supplier development spend |
| MarketBenchmarkIndex | DECIMAL(5,2) | NULL, CHECK > 0 | Market competitiveness index |
| CustomerSatisfactionScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Customer satisfaction rating |
| CategoryManagerPerformanceScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Category manager performance |
| ROIAchieved | DECIMAL(5,2) | NULL | Return on investment achieved |
| DataQualityScore | DECIMAL(5,2) | NOT NULL, DEFAULT 100, CHECK 0.00-100.00 | Data completeness/accuracy |
| LastCalculatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last metric calculation |
| CalculationMethod | VARCHAR(50) | NOT NULL | Calculation methodology |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |

### Constraints

```sql
-- Primary Key
ALTER TABLE CategoryPerformanceMetrics ADD CONSTRAINT PK_CategoryPerformanceMetrics PRIMARY KEY (MetricId);

-- Unique Constraint for Period/Category
ALTER TABLE CategoryPerformanceMetrics ADD CONSTRAINT UK_CategoryPerformanceMetrics_Period 
    UNIQUE (CategoryId, MetricPeriod, MetricType);

-- Foreign Keys
ALTER TABLE CategoryPerformanceMetrics ADD CONSTRAINT FK_CategoryPerformanceMetrics_Category 
    FOREIGN KEY (CategoryId) REFERENCES ProductCategory(CategoryId) ON DELETE CASCADE;
ALTER TABLE CategoryPerformanceMetrics ADD CONSTRAINT FK_CategoryPerformanceMetrics_Currency 
    FOREIGN KEY (SpendCurrencyCode) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE CategoryPerformanceMetrics ADD CONSTRAINT CK_CategoryPerformanceMetrics_MetricType 
    CHECK (MetricType IN ('Monthly', 'Quarterly', 'Annual', 'YTD'));
ALTER TABLE CategoryPerformanceMetrics ADD CONSTRAINT CK_CategoryPerformanceMetrics_CalculationMethod 
    CHECK (CalculationMethod IN ('Automated', 'Semi-Automated', 'Manual', 'System-Generated'));
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_CategoryPerformanceMetrics_CategoryId ON CategoryPerformanceMetrics(CategoryId);
CREATE INDEX IX_CategoryPerformanceMetrics_SpendCurrencyCode ON CategoryPerformanceMetrics(SpendCurrencyCode);

-- Date and Period Indexes
CREATE INDEX IX_CategoryPerformanceMetrics_MetricPeriod ON CategoryPerformanceMetrics(MetricPeriod DESC);
CREATE INDEX IX_CategoryPerformanceMetrics_MetricType ON CategoryPerformanceMetrics(MetricType);

-- Performance Indexes for Reporting
CREATE INDEX IX_CategoryPerformanceMetrics_TotalSpend ON CategoryPerformanceMetrics(TotalSpend DESC);
CREATE INDEX IX_CategoryPerformanceMetrics_CostSavingsPercentage ON CategoryPerformanceMetrics(CostSavingsPercentage DESC);
CREATE INDEX IX_CategoryPerformanceMetrics_AverageRiskScore ON CategoryPerformanceMetrics(AverageRiskScore DESC);

-- Composite Indexes for Common Queries
CREATE INDEX IX_CategoryPerformanceMetrics_Category_Period ON CategoryPerformanceMetrics(CategoryId, MetricPeriod DESC);
CREATE INDEX IX_CategoryPerformanceMetrics_Type_Period ON CategoryPerformanceMetrics(MetricType, MetricPeriod DESC);

-- Partitioning by MetricPeriod (monthly partitions for performance)
-- Implementation depends on database system
```

---

## Entity: CategoryBenchmark

### Purpose
External market benchmarks and competitive positioning data for categories.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| BenchmarkId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| CategoryId | BIGINT | FK, NOT NULL | Reference to product category |
| BenchmarkSource | VARCHAR(100) | NOT NULL | Data source (e.g., industry report) |
| BenchmarkDate | DATE | NOT NULL | Benchmark data date |
| BenchmarkType | VARCHAR(20) | NOT NULL | Market, Industry, Peer, Best-in-Class |
| GeographicScope | VARCHAR(50) | NOT NULL | Global, Regional, Country-specific |
| IndustryScope | VARCHAR(100) | NULL | Industry focus area |
| CompanySize | VARCHAR(20) | NULL | Large, Medium, Small enterprise |
| MarketPriceIndex | DECIMAL(8,4) | NULL, CHECK > 0 | Market price index (base 100) |
| QualityBenchmark | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Quality benchmark score |
| DeliveryBenchmark | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Delivery performance benchmark |
| InnovationBenchmark | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Innovation capability benchmark |
| RiskBenchmark | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Risk management benchmark |
| ESGBenchmark | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | ESG performance benchmark |
| SupplierConcentrationBenchmark | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Supplier concentration benchmark |
| DigitalMaturityBenchmark | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Digital capability benchmark |
| CostStructureBenchmark | TEXT | NULL | Cost structure analysis |
| BestPractices | TEXT | NULL | Industry best practices |
| KeyFindings | TEXT | NULL | Key benchmark findings |
| RecommendedActions | TEXT | NULL | Recommended improvement actions |
| ConfidenceLevel | DECIMAL(5,2) | NOT NULL, DEFAULT 80.00, CHECK 0.00-100.00 | Data confidence level |
| SampleSize | INT | NULL, CHECK >= 0 | Benchmark sample size |
| DataCurrency | VARCHAR(3) | FK, NULL | Currency for monetary values |
| IsPublic | BOOLEAN | NOT NULL, DEFAULT FALSE | Public benchmark flag |
| ExpirationDate | DATE | NULL | Benchmark data expiration |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |

### Constraints

```sql
-- Primary Key
ALTER TABLE CategoryBenchmark ADD CONSTRAINT PK_CategoryBenchmark PRIMARY KEY (BenchmarkId);

-- Foreign Keys
ALTER TABLE CategoryBenchmark ADD CONSTRAINT FK_CategoryBenchmark_Category 
    FOREIGN KEY (CategoryId) REFERENCES ProductCategory(CategoryId) ON DELETE CASCADE;
ALTER TABLE CategoryBenchmark ADD CONSTRAINT FK_CategoryBenchmark_Currency 
    FOREIGN KEY (DataCurrency) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE CategoryBenchmark ADD CONSTRAINT CK_CategoryBenchmark_BenchmarkType 
    CHECK (BenchmarkType IN ('Market', 'Industry', 'Peer', 'Best-in-Class', 'Historical'));
ALTER TABLE CategoryBenchmark ADD CONSTRAINT CK_CategoryBenchmark_CompanySize 
    CHECK (CompanySize IN ('Large', 'Medium', 'Small', 'All', 'Fortune-500', 'Mid-Market') OR CompanySize IS NULL);

-- Business Rules
ALTER TABLE CategoryBenchmark ADD CONSTRAINT CK_CategoryBenchmark_ExpirationDate 
    CHECK (ExpirationDate IS NULL OR ExpirationDate > BenchmarkDate);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_CategoryBenchmark_CategoryId ON CategoryBenchmark(CategoryId);
CREATE INDEX IX_CategoryBenchmark_DataCurrency ON CategoryBenchmark(DataCurrency);

-- Search and Filter Indexes
CREATE INDEX IX_CategoryBenchmark_BenchmarkSource ON CategoryBenchmark(BenchmarkSource);
CREATE INDEX IX_CategoryBenchmark_BenchmarkType ON CategoryBenchmark(BenchmarkType);
CREATE INDEX IX_CategoryBenchmark_GeographicScope ON CategoryBenchmark(GeographicScope);
CREATE INDEX IX_CategoryBenchmark_BenchmarkDate ON CategoryBenchmark(BenchmarkDate DESC);

-- Composite Indexes
CREATE INDEX IX_CategoryBenchmark_Category_Date ON CategoryBenchmark(CategoryId, BenchmarkDate DESC);
CREATE INDEX IX_CategoryBenchmark_Type_Date ON CategoryBenchmark(BenchmarkType, BenchmarkDate DESC);
```

---

## Reference Tables

### Entity: CategoryClassification

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| ClassificationCode | VARCHAR(20) | PK, NOT NULL | Classification code |
| ClassificationName | VARCHAR(100) | NOT NULL | Classification name |
| ClassificationSystem | VARCHAR(50) | NOT NULL | UNSPSC, NAICS, SIC, etc. |
| ParentClassificationCode | VARCHAR(20) | FK, NULL | Parent classification |
| Level | INT | NOT NULL | Classification level |
| Description | TEXT | NULL | Classification description |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active classification flag |

### Entity: QualityStandard

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| StandardCode | VARCHAR(20) | PK, NOT NULL | Quality standard code |
| StandardName | VARCHAR(255) | NOT NULL | Quality standard name |
| IssuingOrganization | VARCHAR(255) | NOT NULL | Standards organization |
| StandardVersion | VARCHAR(20) | NULL | Current version |
| Description | TEXT | NOT NULL | Standard description |
| RequirementLevel | VARCHAR(10) | NOT NULL | Basic, Standard, Advanced, Critical |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active standard flag |

---

## Business Rules and Calculations

### Category Hierarchy Management

```sql
-- Function to calculate category path
CREATE FUNCTION CalculateCategoryPath(@CategoryId BIGINT)
RETURNS VARCHAR(1000)
AS
BEGIN
    DECLARE @Path VARCHAR(1000) = '';
    DECLARE @CurrentId BIGINT = @CategoryId;
    DECLARE @CurrentCode VARCHAR(20);
    
    WHILE @CurrentId IS NOT NULL
    BEGIN
        SELECT @CurrentCode = CategoryCode, @CurrentId = ParentCategoryId
        FROM ProductCategory
        WHERE CategoryId = @CurrentId;
        
        IF @Path = ''
            SET @Path = @CurrentCode;
        ELSE
            SET @Path = @CurrentCode + '/' + @Path;
    END
    
    RETURN @Path;
END;
```

### Performance Metric Calculations

```sql
-- Stored procedure to calculate category performance metrics
CREATE PROCEDURE CalculateCategoryMetrics(
    @CategoryId BIGINT,
    @PeriodStart DATE,
    @PeriodEnd DATE
)
AS
BEGIN
    -- Implementation to calculate various performance metrics
    -- from transaction data, supplier assessments, and external sources
    
    INSERT INTO CategoryPerformanceMetrics (
        CategoryId,
        MetricPeriod,
        TotalSpend,
        NumberOfSuppliers,
        -- ... other calculated metrics
    )
    SELECT 
        @CategoryId,
        @PeriodEnd,
        SUM(spend calculations),
        COUNT(DISTINCT supplier calculations),
        -- ... other metric calculations
    FROM various_source_tables
    WHERE conditions;
END;
```

### Category Review Workflow

1. **Quarterly Reviews**: Performance against targets
2. **Annual Strategic Reviews**: Strategy effectiveness and updates
3. **Triggered Reviews**: Significant market or supplier changes
4. **Benchmark Reviews**: Competitive positioning assessment

---

## Data Quality Rules

### Category Management
- Category codes must be unique and follow naming conventions
- Category hierarchy must not have circular references
- Each category must have an assigned active category manager
- Strategic categories must have approved sourcing strategies

### Performance Metrics
- Metrics must be calculated using approved methodologies
- Data quality scores must reflect completeness and accuracy
- Historical metrics must be preserved for trending analysis
- Benchmark data must be validated and source-attributed

### Sourcing Strategy
- Strategies must have approved objectives and targets
- Review dates must be scheduled and tracked
- Strategy changes must be documented and approved
- Compliance requirements must be clearly defined

---

*Document Version*: 1.0  
*Last Updated*: August 21, 2025  
*Next Review*: September 21, 2025  
*Document Owner*: Category Management Team
