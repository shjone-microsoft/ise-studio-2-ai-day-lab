# Risk Assessment Entities - Logical Data Model

## Overview
This document defines the logical structure for risk assessment entities, including risk scoring frameworks, risk indicators, and historical risk tracking.

---

## Entity: RiskAssessment

### Purpose
Central entity for comprehensive supplier risk evaluations with real-time scoring and trend analysis.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| RiskAssessmentId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| SupplierId | BIGINT | FK, NOT NULL | Reference to supplier |
| AssessmentDate | TIMESTAMP | NOT NULL | Date/time of risk assessment |
| AssessmentType | VARCHAR(20) | NOT NULL | Initial, Periodic, Triggered, Emergency |
| OverallRiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Composite risk score |
| RiskLevel | VARCHAR(10) | NOT NULL | Low, Medium, High, Critical |
| RiskTrend | VARCHAR(15) | NOT NULL | Improving, Stable, Deteriorating |
| FinancialRiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Financial stability risk |
| OperationalRiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Operational capability risk |
| GeographicRiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Geographic/political risk |
| RegulatoryRiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Regulatory compliance risk |
| ESGRiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Environmental/social/governance risk |
| TariffRiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Trade policy/tariff risk |
| CyberSecurityRiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Cybersecurity risk |
| SupplyChainRiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Supply chain disruption risk |
| ConfidenceLevel | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Assessment confidence percentage |
| DataQualityScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Quality of underlying data |
| ModelVersion | VARCHAR(20) | NOT NULL | Risk model version used |
| NextAssessmentDate | TIMESTAMP | NOT NULL | Scheduled next assessment |
| AssessmentMethod | VARCHAR(20) | NOT NULL | Automated, Manual, Hybrid |
| AssessedBy | VARCHAR(100) | NULL | User or system that performed assessment |
| ReviewedBy | VARCHAR(100) | NULL | User who reviewed assessment |
| ReviewedDate | TIMESTAMP | NULL | Date assessment was reviewed |
| ApprovedBy | VARCHAR(100) | NULL | User who approved assessment |
| ApprovedDate | TIMESTAMP | NULL | Date assessment was approved |
| Status | VARCHAR(15) | NOT NULL, DEFAULT 'Draft' | Draft, Pending, Approved, Superseded |
| Notes | TEXT | NULL | Assessment notes and comments |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE RiskAssessment ADD CONSTRAINT PK_RiskAssessment PRIMARY KEY (RiskAssessmentId);

-- Foreign Keys
ALTER TABLE RiskAssessment ADD CONSTRAINT FK_RiskAssessment_Supplier 
    FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId);

-- Check Constraints
ALTER TABLE RiskAssessment ADD CONSTRAINT CK_RiskAssessment_AssessmentType 
    CHECK (AssessmentType IN ('Initial', 'Periodic', 'Triggered', 'Emergency', 'Ad-Hoc'));
ALTER TABLE RiskAssessment ADD CONSTRAINT CK_RiskAssessment_RiskLevel 
    CHECK (RiskLevel IN ('Low', 'Medium', 'High', 'Critical'));
ALTER TABLE RiskAssessment ADD CONSTRAINT CK_RiskAssessment_RiskTrend 
    CHECK (RiskTrend IN ('Improving', 'Stable', 'Deteriorating'));
ALTER TABLE RiskAssessment ADD CONSTRAINT CK_RiskAssessment_AssessmentMethod 
    CHECK (AssessmentMethod IN ('Automated', 'Manual', 'Hybrid'));
ALTER TABLE RiskAssessment ADD CONSTRAINT CK_RiskAssessment_Status 
    CHECK (Status IN ('Draft', 'Pending', 'Approved', 'Superseded'));

-- Business Rules
ALTER TABLE RiskAssessment ADD CONSTRAINT CK_RiskAssessment_NextAssessmentDate 
    CHECK (NextAssessmentDate > AssessmentDate);
ALTER TABLE RiskAssessment ADD CONSTRAINT CK_RiskAssessment_ReviewDate 
    CHECK (ReviewedDate IS NULL OR ReviewedDate >= AssessmentDate);
ALTER TABLE RiskAssessment ADD CONSTRAINT CK_RiskAssessment_ApprovalDate 
    CHECK (ApprovedDate IS NULL OR ApprovedDate >= AssessmentDate);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_RiskAssessment_SupplierId ON RiskAssessment(SupplierId);

-- Date-based Indexes
CREATE INDEX IX_RiskAssessment_AssessmentDate ON RiskAssessment(AssessmentDate DESC);
CREATE INDEX IX_RiskAssessment_NextAssessmentDate ON RiskAssessment(NextAssessmentDate);

-- Risk Level Indexes
CREATE INDEX IX_RiskAssessment_OverallRiskScore ON RiskAssessment(OverallRiskScore DESC);
CREATE INDEX IX_RiskAssessment_RiskLevel ON RiskAssessment(RiskLevel);
CREATE INDEX IX_RiskAssessment_Status ON RiskAssessment(Status);

-- Composite Indexes for Common Queries
CREATE INDEX IX_RiskAssessment_Supplier_Date ON RiskAssessment(SupplierId, AssessmentDate DESC);
CREATE INDEX IX_RiskAssessment_Level_Date ON RiskAssessment(RiskLevel, AssessmentDate DESC);
CREATE INDEX IX_RiskAssessment_Status_Date ON RiskAssessment(Status, AssessmentDate DESC);

-- Partitioning by AssessmentDate (monthly partitions)
-- Implementation depends on database system
```

---

## Entity: RiskFactor

### Purpose
Individual risk indicators and factors that contribute to overall risk assessment scores.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| RiskFactorId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| RiskAssessmentId | BIGINT | FK, NOT NULL | Reference to risk assessment |
| RiskCategoryCode | VARCHAR(20) | FK, NOT NULL | Risk category classification |
| RiskIndicatorCode | VARCHAR(50) | FK, NOT NULL | Specific risk indicator |
| FactorName | VARCHAR(255) | NOT NULL | Human-readable factor name |
| FactorDescription | TEXT | NULL | Detailed description of risk factor |
| RiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Individual factor risk score |
| SeverityLevel | VARCHAR(10) | NOT NULL | Low, Medium, High, Critical |
| LikelihoodScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Probability of occurrence |
| ImpactScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Potential business impact |
| Weight | DECIMAL(5,4) | NOT NULL, CHECK 0.0000-1.0000 | Weight in overall calculation |
| DataSource | VARCHAR(100) | NOT NULL | Source of risk factor data |
| DataFreshness | VARCHAR(20) | NOT NULL | Real-time, Daily, Weekly, Monthly |
| DetectionDate | TIMESTAMP | NOT NULL | When factor was first detected |
| LastUpdateDate | TIMESTAMP | NOT NULL | Last data update timestamp |
| ExpirationDate | TIMESTAMP | NULL | When factor data expires |
| ConfidenceLevel | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Confidence in factor accuracy |
| IsAutomated | BOOLEAN | NOT NULL, DEFAULT TRUE | Automated vs manual detection |
| AlertThreshold | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Score threshold for alerts |
| HasTriggeredAlert | BOOLEAN | NOT NULL, DEFAULT FALSE | Whether alert was triggered |
| AlertDate | TIMESTAMP | NULL | When alert was triggered |
| MitigationActions | TEXT | NULL | Recommended mitigation actions |
| OwnerUserId | VARCHAR(50) | NULL | User responsible for factor |
| Status | VARCHAR(15) | NOT NULL, DEFAULT 'Active' | Active, Resolved, Suppressed |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |

### Constraints

```sql
-- Primary Key
ALTER TABLE RiskFactor ADD CONSTRAINT PK_RiskFactor PRIMARY KEY (RiskFactorId);

-- Foreign Keys
ALTER TABLE RiskFactor ADD CONSTRAINT FK_RiskFactor_RiskAssessment 
    FOREIGN KEY (RiskAssessmentId) REFERENCES RiskAssessment(RiskAssessmentId) ON DELETE CASCADE;
ALTER TABLE RiskFactor ADD CONSTRAINT FK_RiskFactor_RiskCategory 
    FOREIGN KEY (RiskCategoryCode) REFERENCES RiskCategory(CategoryCode);
ALTER TABLE RiskFactor ADD CONSTRAINT FK_RiskFactor_RiskIndicator 
    FOREIGN KEY (RiskIndicatorCode) REFERENCES RiskIndicator(IndicatorCode);

-- Check Constraints
ALTER TABLE RiskFactor ADD CONSTRAINT CK_RiskFactor_SeverityLevel 
    CHECK (SeverityLevel IN ('Low', 'Medium', 'High', 'Critical'));
ALTER TABLE RiskFactor ADD CONSTRAINT CK_RiskFactor_DataFreshness 
    CHECK (DataFreshness IN ('Real-time', 'Hourly', 'Daily', 'Weekly', 'Monthly', 'Quarterly'));
ALTER TABLE RiskFactor ADD CONSTRAINT CK_RiskFactor_Status 
    CHECK (Status IN ('Active', 'Resolved', 'Suppressed', 'Expired'));

-- Business Rules
ALTER TABLE RiskFactor ADD CONSTRAINT CK_RiskFactor_LastUpdateDate 
    CHECK (LastUpdateDate >= DetectionDate);
ALTER TABLE RiskFactor ADD CONSTRAINT CK_RiskFactor_AlertDate 
    CHECK (AlertDate IS NULL OR AlertDate >= DetectionDate);
ALTER TABLE RiskFactor ADD CONSTRAINT CK_RiskFactor_AlertThresholdTrigger 
    CHECK (HasTriggeredAlert = FALSE OR AlertThreshold IS NOT NULL);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_RiskFactor_RiskAssessmentId ON RiskFactor(RiskAssessmentId);
CREATE INDEX IX_RiskFactor_RiskCategoryCode ON RiskFactor(RiskCategoryCode);
CREATE INDEX IX_RiskFactor_RiskIndicatorCode ON RiskFactor(RiskIndicatorCode);

-- Search and Alert Indexes
CREATE INDEX IX_RiskFactor_SeverityLevel ON RiskFactor(SeverityLevel);
CREATE INDEX IX_RiskFactor_HasTriggeredAlert ON RiskFactor(HasTriggeredAlert);
CREATE INDEX IX_RiskFactor_AlertDate ON RiskFactor(AlertDate DESC);
CREATE INDEX IX_RiskFactor_Status ON RiskFactor(Status);

-- Date-based Indexes
CREATE INDEX IX_RiskFactor_DetectionDate ON RiskFactor(DetectionDate DESC);
CREATE INDEX IX_RiskFactor_LastUpdateDate ON RiskFactor(LastUpdateDate DESC);
CREATE INDEX IX_RiskFactor_ExpirationDate ON RiskFactor(ExpirationDate);

-- Composite Indexes
CREATE INDEX IX_RiskFactor_Category_Severity ON RiskFactor(RiskCategoryCode, SeverityLevel);
CREATE INDEX IX_RiskFactor_Alert_Date ON RiskFactor(HasTriggeredAlert, AlertDate DESC);
```

---

## Entity: RiskAlertHistory

### Purpose
Tracks risk alert notifications and their resolution status.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| AlertId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| RiskAssessmentId | BIGINT | FK, NOT NULL | Reference to risk assessment |
| RiskFactorId | BIGINT | FK, NULL | Reference to specific risk factor |
| SupplierId | BIGINT | FK, NOT NULL | Reference to supplier |
| AlertType | VARCHAR(20) | NOT NULL | Threshold, Trend, Emergency, etc. |
| AlertLevel | VARCHAR(10) | NOT NULL | Low, Medium, High, Critical |
| AlertTitle | VARCHAR(255) | NOT NULL | Brief alert description |
| AlertDescription | TEXT | NOT NULL | Detailed alert information |
| TriggerValue | DECIMAL(10,4) | NULL | Value that triggered alert |
| ThresholdValue | DECIMAL(10,4) | NULL | Threshold that was exceeded |
| AlertDate | TIMESTAMP | NOT NULL | When alert was generated |
| DetectedBy | VARCHAR(100) | NOT NULL | System or user that detected alert |
| AssignedTo | VARCHAR(100) | NULL | User assigned to handle alert |
| AssignedDate | TIMESTAMP | NULL | When alert was assigned |
| EscalationLevel | INT | NOT NULL, DEFAULT 0 | Current escalation level |
| EscalationDate | TIMESTAMP | NULL | Last escalation timestamp |
| Priority | VARCHAR(10) | NOT NULL, DEFAULT 'Medium' | Low, Medium, High, Urgent |
| Status | VARCHAR(15) | NOT NULL, DEFAULT 'Open' | Open, Assigned, InProgress, Resolved, Closed |
| ResolutionDate | TIMESTAMP | NULL | When alert was resolved |
| ResolutionNotes | TEXT | NULL | Notes about resolution |
| ResolvedBy | VARCHAR(100) | NULL | User who resolved alert |
| NotificationsSent | INT | NOT NULL, DEFAULT 0 | Number of notifications sent |
| LastNotificationDate | TIMESTAMP | NULL | Last notification timestamp |
| AcknowledgedBy | VARCHAR(100) | NULL | User who acknowledged alert |
| AcknowledgedDate | TIMESTAMP | NULL | When alert was acknowledged |
| BusinessImpact | TEXT | NULL | Assessment of business impact |
| MitigationActions | TEXT | NULL | Actions taken to mitigate risk |
| LessonsLearned | TEXT | NULL | Lessons learned for future |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |

### Constraints

```sql
-- Primary Key
ALTER TABLE RiskAlertHistory ADD CONSTRAINT PK_RiskAlertHistory PRIMARY KEY (AlertId);

-- Foreign Keys
ALTER TABLE RiskAlertHistory ADD CONSTRAINT FK_RiskAlertHistory_RiskAssessment 
    FOREIGN KEY (RiskAssessmentId) REFERENCES RiskAssessment(RiskAssessmentId);
ALTER TABLE RiskAlertHistory ADD CONSTRAINT FK_RiskAlertHistory_RiskFactor 
    FOREIGN KEY (RiskFactorId) REFERENCES RiskFactor(RiskFactorId);
ALTER TABLE RiskAlertHistory ADD CONSTRAINT FK_RiskAlertHistory_Supplier 
    FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId);

-- Check Constraints
ALTER TABLE RiskAlertHistory ADD CONSTRAINT CK_RiskAlertHistory_AlertType 
    CHECK (AlertType IN ('Threshold', 'Trend', 'Emergency', 'Compliance', 'Financial', 'Operational'));
ALTER TABLE RiskAlertHistory ADD CONSTRAINT CK_RiskAlertHistory_AlertLevel 
    CHECK (AlertLevel IN ('Low', 'Medium', 'High', 'Critical'));
ALTER TABLE RiskAlertHistory ADD CONSTRAINT CK_RiskAlertHistory_Priority 
    CHECK (Priority IN ('Low', 'Medium', 'High', 'Urgent'));
ALTER TABLE RiskAlertHistory ADD CONSTRAINT CK_RiskAlertHistory_Status 
    CHECK (Status IN ('Open', 'Assigned', 'InProgress', 'Resolved', 'Closed', 'Cancelled'));

-- Business Rules
ALTER TABLE RiskAlertHistory ADD CONSTRAINT CK_RiskAlertHistory_EscalationLevel 
    CHECK (EscalationLevel >= 0 AND EscalationLevel <= 5);
ALTER TABLE RiskAlertHistory ADD CONSTRAINT CK_RiskAlertHistory_AssignedDate 
    CHECK (AssignedDate IS NULL OR AssignedDate >= AlertDate);
ALTER TABLE RiskAlertHistory ADD CONSTRAINT CK_RiskAlertHistory_ResolutionDate 
    CHECK (ResolutionDate IS NULL OR ResolutionDate >= AlertDate);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_RiskAlertHistory_RiskAssessmentId ON RiskAlertHistory(RiskAssessmentId);
CREATE INDEX IX_RiskAlertHistory_RiskFactorId ON RiskAlertHistory(RiskFactorId);
CREATE INDEX IX_RiskAlertHistory_SupplierId ON RiskAlertHistory(SupplierId);

-- Status and Priority Indexes
CREATE INDEX IX_RiskAlertHistory_Status ON RiskAlertHistory(Status);
CREATE INDEX IX_RiskAlertHistory_Priority ON RiskAlertHistory(Priority);
CREATE INDEX IX_RiskAlertHistory_AlertLevel ON RiskAlertHistory(AlertLevel);
CREATE INDEX IX_RiskAlertHistory_AssignedTo ON RiskAlertHistory(AssignedTo);

-- Date-based Indexes
CREATE INDEX IX_RiskAlertHistory_AlertDate ON RiskAlertHistory(AlertDate DESC);
CREATE INDEX IX_RiskAlertHistory_ResolutionDate ON RiskAlertHistory(ResolutionDate DESC);
CREATE INDEX IX_RiskAlertHistory_EscalationDate ON RiskAlertHistory(EscalationDate DESC);

-- Composite Indexes
CREATE INDEX IX_RiskAlertHistory_Status_Date ON RiskAlertHistory(Status, AlertDate DESC);
CREATE INDEX IX_RiskAlertHistory_Supplier_Status ON RiskAlertHistory(SupplierId, Status);
CREATE INDEX IX_RiskAlertHistory_Level_Date ON RiskAlertHistory(AlertLevel, AlertDate DESC);
```

---

## Entity: RiskMitigationPlan

### Purpose
Manages risk mitigation strategies and action plans for suppliers.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| MitigationPlanId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| SupplierId | BIGINT | FK, NOT NULL | Reference to supplier |
| RiskAssessmentId | BIGINT | FK, NOT NULL | Reference to risk assessment |
| PlanName | VARCHAR(255) | NOT NULL | Mitigation plan name |
| PlanDescription | TEXT | NOT NULL | Detailed plan description |
| RiskCategory | VARCHAR(50) | NOT NULL | Category of risk being mitigated |
| CurrentRiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Current risk score |
| TargetRiskScore | DECIMAL(5,2) | NOT NULL, CHECK 0.00-100.00 | Target risk score after mitigation |
| Priority | VARCHAR(10) | NOT NULL | Low, Medium, High, Critical |
| Status | VARCHAR(20) | NOT NULL, DEFAULT 'Draft' | Draft, Approved, InProgress, Completed |
| OwnerUserId | VARCHAR(50) | NOT NULL | Plan owner/responsible party |
| BusinessSponsor | VARCHAR(100) | NULL | Business sponsor |
| EstimatedCost | DECIMAL(15,2) | NULL, CHECK >= 0 | Estimated implementation cost |
| CostCurrencyCode | VARCHAR(3) | FK, NULL | Currency for cost estimate |
| EstimatedROI | DECIMAL(5,2) | NULL | Estimated return on investment |
| PlannedStartDate | DATE | NOT NULL | Planned implementation start |
| PlannedEndDate | DATE | NOT NULL | Planned completion date |
| ActualStartDate | DATE | NULL | Actual implementation start |
| ActualEndDate | DATE | NULL | Actual completion date |
| CompletionPercentage | DECIMAL(5,2) | NOT NULL, DEFAULT 0.00, CHECK 0.00-100.00 | Completion percentage |
| SuccessCriteria | TEXT | NOT NULL | Success measurement criteria |
| Dependencies | TEXT | NULL | Plan dependencies |
| Assumptions | TEXT | NULL | Key assumptions |
| Risks | TEXT | NULL | Implementation risks |
| ApprovedBy | VARCHAR(100) | NULL | User who approved plan |
| ApprovedDate | TIMESTAMP | NULL | Plan approval date |
| ReviewDate | DATE | NULL | Next review date |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE RiskMitigationPlan ADD CONSTRAINT PK_RiskMitigationPlan PRIMARY KEY (MitigationPlanId);

-- Foreign Keys
ALTER TABLE RiskMitigationPlan ADD CONSTRAINT FK_RiskMitigationPlan_Supplier 
    FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId);
ALTER TABLE RiskMitigationPlan ADD CONSTRAINT FK_RiskMitigationPlan_RiskAssessment 
    FOREIGN KEY (RiskAssessmentId) REFERENCES RiskAssessment(RiskAssessmentId);
ALTER TABLE RiskMitigationPlan ADD CONSTRAINT FK_RiskMitigationPlan_Currency 
    FOREIGN KEY (CostCurrencyCode) REFERENCES Currency(CurrencyCode);

-- Check Constraints
ALTER TABLE RiskMitigationPlan ADD CONSTRAINT CK_RiskMitigationPlan_Priority 
    CHECK (Priority IN ('Low', 'Medium', 'High', 'Critical'));
ALTER TABLE RiskMitigationPlan ADD CONSTRAINT CK_RiskMitigationPlan_Status 
    CHECK (Status IN ('Draft', 'Approved', 'InProgress', 'Completed', 'Cancelled', 'OnHold'));

-- Business Rules
ALTER TABLE RiskMitigationPlan ADD CONSTRAINT CK_RiskMitigationPlan_PlannedDates 
    CHECK (PlannedEndDate >= PlannedStartDate);
ALTER TABLE RiskMitigationPlan ADD CONSTRAINT CK_RiskMitigationPlan_ActualDates 
    CHECK (ActualEndDate IS NULL OR ActualStartDate IS NOT NULL);
ALTER TABLE RiskMitigationPlan ADD CONSTRAINT CK_RiskMitigationPlan_TargetScore 
    CHECK (TargetRiskScore <= CurrentRiskScore);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_RiskMitigationPlan_SupplierId ON RiskMitigationPlan(SupplierId);
CREATE INDEX IX_RiskMitigationPlan_RiskAssessmentId ON RiskMitigationPlan(RiskAssessmentId);
CREATE INDEX IX_RiskMitigationPlan_OwnerUserId ON RiskMitigationPlan(OwnerUserId);

-- Status and Priority Indexes
CREATE INDEX IX_RiskMitigationPlan_Status ON RiskMitigationPlan(Status);
CREATE INDEX IX_RiskMitigationPlan_Priority ON RiskMitigationPlan(Priority);

-- Date-based Indexes
CREATE INDEX IX_RiskMitigationPlan_PlannedStartDate ON RiskMitigationPlan(PlannedStartDate);
CREATE INDEX IX_RiskMitigationPlan_PlannedEndDate ON RiskMitigationPlan(PlannedEndDate);
CREATE INDEX IX_RiskMitigationPlan_ReviewDate ON RiskMitigationPlan(ReviewDate);

-- Composite Indexes
CREATE INDEX IX_RiskMitigationPlan_Supplier_Status ON RiskMitigationPlan(SupplierId, Status);
CREATE INDEX IX_RiskMitigationPlan_Status_Priority ON RiskMitigationPlan(Status, Priority);
```

---

## Reference Tables

### Entity: RiskCategory

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| CategoryCode | VARCHAR(20) | PK, NOT NULL | Unique category code |
| CategoryName | VARCHAR(100) | NOT NULL | Category display name |
| Description | TEXT | NULL | Category description |
| ParentCategoryCode | VARCHAR(20) | FK, NULL | Parent category for hierarchy |
| Weight | DECIMAL(5,4) | NOT NULL, CHECK 0.0000-1.0000 | Weight in overall risk calculation |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active category flag |
| SortOrder | INT | NOT NULL, DEFAULT 0 | Display sort order |

### Entity: RiskIndicator

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| IndicatorCode | VARCHAR(50) | PK, NOT NULL | Unique indicator code |
| IndicatorName | VARCHAR(255) | NOT NULL | Indicator display name |
| Description | TEXT | NOT NULL | Detailed indicator description |
| CategoryCode | VARCHAR(20) | FK, NOT NULL | Associated risk category |
| DataSource | VARCHAR(100) | NOT NULL | Source system or provider |
| CalculationMethod | TEXT | NOT NULL | How indicator is calculated |
| LowThreshold | DECIMAL(10,4) | NULL | Low risk threshold |
| MediumThreshold | DECIMAL(10,4) | NULL | Medium risk threshold |
| HighThreshold | DECIMAL(10,4) | NULL | High risk threshold |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active indicator flag |

---

## Business Rules and Calculated Fields

### Risk Score Calculations

```sql
-- Function to calculate overall risk score
CREATE FUNCTION CalculateOverallRiskScore(
    @FinancialRisk DECIMAL(5,2),
    @OperationalRisk DECIMAL(5,2),
    @GeographicRisk DECIMAL(5,2),
    @RegulatoryRisk DECIMAL(5,2),
    @ESGRisk DECIMAL(5,2),
    @TariffRisk DECIMAL(5,2),
    @CyberRisk DECIMAL(5,2),
    @SupplyChainRisk DECIMAL(5,2)
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @OverallScore DECIMAL(5,2);
    
    -- Weighted calculation based on risk category weights
    SELECT @OverallScore = (
        (@FinancialRisk * 0.25) +
        (@OperationalRisk * 0.20) +
        (@GeographicRisk * 0.15) +
        (@RegulatoryRisk * 0.15) +
        (@ESGRisk * 0.10) +
        (@TariffRisk * 0.05) +
        (@CyberRisk * 0.05) +
        (@SupplyChainRisk * 0.05)
    );
    
    RETURN @OverallScore;
END;
```

### Risk Level Determination

```sql
-- Function to determine risk level from score
CREATE FUNCTION DetermineRiskLevel(@RiskScore DECIMAL(5,2))
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @RiskLevel VARCHAR(10);
    
    IF @RiskScore >= 75.00 SET @RiskLevel = 'Critical';
    ELSE IF @RiskScore >= 50.00 SET @RiskLevel = 'High';
    ELSE IF @RiskScore >= 25.00 SET @RiskLevel = 'Medium';
    ELSE SET @RiskLevel = 'Low';
    
    RETURN @RiskLevel;
END;
```

### Alert Generation Rules

1. **Critical Risk Alert**: Overall risk score >= 75.00
2. **High Risk Alert**: Overall risk score >= 50.00 and trend = 'Deteriorating'
3. **Threshold Alert**: Any category score increases by >10 points in 30 days
4. **Data Freshness Alert**: Risk data older than defined freshness requirements
5. **Missing Assessment Alert**: Supplier without assessment for >90 days

---

## Data Quality and Validation

### Risk Score Validation
- All risk scores must be between 0.00 and 100.00
- Overall risk score must be calculated using approved weighting formula
- Risk levels must correspond to defined score ranges
- Confidence levels must reflect data quality and model accuracy

### Assessment Workflow Validation
- Initial assessments required for all new suppliers
- Periodic assessments scheduled based on risk level
- Emergency assessments triggered by significant risk events
- All assessments must be reviewed and approved before activation

### Data Freshness Requirements
- Financial data: Updated daily for high-risk suppliers
- Geographic/political data: Updated weekly
- Regulatory compliance data: Updated monthly
- ESG data: Updated quarterly
- Supplier-provided data: Validated annually

---

*Document Version*: 1.0  
*Last Updated*: August 21, 2025  
*Next Review*: September 21, 2025  
*Document Owner*: Risk Management Team
