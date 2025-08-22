# Assessment Workflow Entities - Logical Data Model

## Overview
This document defines the logical structure for supplier assessment workflows, qualification processes, and development program management.

---

## Entity: AssessmentWorkflow

### Purpose
Central entity managing structured supplier qualification, assessment, and development workflows with approval processes.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| WorkflowId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| WorkflowCode | VARCHAR(50) | UK, NOT NULL | Business workflow identifier |
| WorkflowName | VARCHAR(255) | NOT NULL | Workflow display name |
| WorkflowType | VARCHAR(30) | NOT NULL | Qualification, Assessment, Development, etc. |
| WorkflowCategory | VARCHAR(30) | NOT NULL | Initial, Periodic, Triggered, etc. |
| SupplierId | BIGINT | FK, NOT NULL | Reference to supplier being assessed |
| CategoryId | BIGINT | FK, NULL | Reference to product category (optional) |
| InitiatingUserId | VARCHAR(50) | FK, NOT NULL | User who initiated workflow |
| AssignedUserId | VARCHAR(50) | FK, NULL | Primary user assigned to workflow |
| AssignedTeam | VARCHAR(100) | NULL | Team assigned to workflow |
| WorkflowTemplate | VARCHAR(100) | FK, NULL | Template used for workflow |
| Priority | VARCHAR(10) | NOT NULL, DEFAULT 'Medium' | Low, Medium, High, Urgent |
| BusinessJustification | TEXT | NOT NULL | Business justification for assessment |
| Objectives | TEXT | NOT NULL | Workflow objectives |
| Scope | TEXT | NOT NULL | Assessment scope definition |
| SuccessCriteria | TEXT | NULL | Success measurement criteria |
| EstimatedDuration | INT | NULL, CHECK > 0 | Estimated duration in days |
| EstimatedEffort | DECIMAL(8,2) | NULL, CHECK >= 0 | Estimated effort in hours |
| EstimatedCost | DECIMAL(15,2) | NULL, CHECK >= 0 | Estimated cost |
| CostCurrency | VARCHAR(3) | FK, NULL | Cost currency |
| RequestedStartDate | DATE | NULL | Requested start date |
| PlannedStartDate | DATE | NULL | Planned start date |
| ActualStartDate | DATE | NULL | Actual start date |
| PlannedEndDate | DATE | NULL | Planned completion date |
| ActualEndDate | DATE | NULL | Actual completion date |
| CurrentStage | VARCHAR(50) | NOT NULL, DEFAULT 'Initiated' | Current workflow stage |
| CurrentStageStartDate | DATE | NULL | Current stage start date |
| NextMilestone | VARCHAR(255) | NULL | Next milestone description |
| NextMilestoneDate | DATE | NULL | Next milestone due date |
| OverallStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Draft' | Overall workflow status |
| CompletionPercentage | DECIMAL(5,2) | NOT NULL, DEFAULT 0.00, CHECK 0.00-100.00 | Completion percentage |
| QualityGatesPassed | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Quality gates passed |
| QualityGatesTotal | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Total quality gates |
| DocumentsRequired | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Documents required |
| DocumentsReceived | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Documents received |
| SiteVisitsRequired | INT | NULL, CHECK >= 0 | Site visits required |
| SiteVisitsCompleted | INT | NULL, CHECK >= 0 | Site visits completed |
| InterviewsRequired | INT | NULL, CHECK >= 0 | Interviews required |
| InterviewsCompleted | INT | NULL, CHECK >= 0 | Interviews completed |
| TestsRequired | INT | NULL, CHECK >= 0 | Tests/evaluations required |
| TestsCompleted | INT | NULL, CHECK >= 0 | Tests/evaluations completed |
| ReferenceChecksRequired | INT | NULL, CHECK >= 0 | Reference checks required |
| ReferenceChecksCompleted | INT | NULL, CHECK >= 0 | Reference checks completed |
| OverallScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Overall assessment score |
| TechnicalScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Technical assessment score |
| QualityScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Quality assessment score |
| CapacityScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Capacity assessment score |
| FinancialScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Financial assessment score |
| ComplianceScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Compliance assessment score |
| ESGScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | ESG assessment score |
| RiskScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Risk assessment score |
| RecommendedAction | VARCHAR(30) | NULL | Approve, Reject, Conditional, etc. |
| QualificationDecision | VARCHAR(30) | NULL | Final qualification decision |
| QualificationLevel | VARCHAR(30) | NULL | Qualification level granted |
| ConditionalRequirements | TEXT | NULL | Conditional approval requirements |
| ImprovementPlan | TEXT | NULL | Required improvements |
| DevelopmentOpportunities | TEXT | NULL | Development opportunities identified |
| NextAssessmentDate | DATE | NULL | Next assessment scheduled |
| ReviewerUserId | VARCHAR(50) | FK, NULL | Primary reviewer |
| ReviewNotes | TEXT | NULL | Review comments |
| ReviewDate | TIMESTAMP | NULL | Review completion date |
| ApproverUserId | VARCHAR(50) | FK, NULL | Final approver |
| ApprovalNotes | TEXT | NULL | Approval comments |
| ApprovalDate | TIMESTAMP | NULL | Approval timestamp |
| RejectionReason | TEXT | NULL | Rejection rationale |
| AppealProcess | TEXT | NULL | Appeal process information |
| LessonsLearned | TEXT | NULL | Process improvement insights |
| FollowUpActions | TEXT | NULL | Required follow-up actions |
| EscalationLevel | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Current escalation level |
| EscalationReason | TEXT | NULL | Escalation reason |
| EscalationDate | TIMESTAMP | NULL | Last escalation date |
| CommunicationLog | TEXT | NULL | Key communications summary |
| IssuesEncountered | TEXT | NULL | Issues and resolutions |
| RiskMitigations | TEXT | NULL | Risk mitigation actions |
| StakeholderFeedback | TEXT | NULL | Stakeholder feedback summary |
| CustomerImpact | TEXT | NULL | Customer impact assessment |
| BusinessImpact | TEXT | NULL | Business impact assessment |
| ROIProjection | DECIMAL(5,2) | NULL | Projected return on investment |
| PaybackPeriod | DECIMAL(8,2) | NULL, CHECK > 0 | Payback period in months |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active workflow flag |
| IsRecurring | BOOLEAN | NOT NULL, DEFAULT FALSE | Recurring assessment flag |
| RecurrenceInterval | INT | NULL, CHECK > 0 | Recurrence interval in months |
| ConfidentialityLevel | VARCHAR(20) | NOT NULL, DEFAULT 'Standard' | Confidentiality classification |
| DataRetentionPeriod | INT | NULL, CHECK > 0 | Data retention in months |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT PK_AssessmentWorkflow PRIMARY KEY (WorkflowId);

-- Unique Constraints
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT UK_AssessmentWorkflow_WorkflowCode UNIQUE (WorkflowCode);

-- Foreign Keys
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT FK_AssessmentWorkflow_Supplier 
    FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT FK_AssessmentWorkflow_Category 
    FOREIGN KEY (CategoryId) REFERENCES ProductCategory(CategoryId);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT FK_AssessmentWorkflow_InitiatingUser 
    FOREIGN KEY (InitiatingUserId) REFERENCES UserProfile(UserId);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT FK_AssessmentWorkflow_AssignedUser 
    FOREIGN KEY (AssignedUserId) REFERENCES UserProfile(UserId);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT FK_AssessmentWorkflow_ReviewerUser 
    FOREIGN KEY (ReviewerUserId) REFERENCES UserProfile(UserId);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT FK_AssessmentWorkflow_ApproverUser 
    FOREIGN KEY (ApproverUserId) REFERENCES UserProfile(UserId);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT FK_AssessmentWorkflow_CostCurrency 
    FOREIGN KEY (CostCurrency) REFERENCES Currency(CurrencyCode);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT FK_AssessmentWorkflow_WorkflowTemplate 
    FOREIGN KEY (WorkflowTemplate) REFERENCES WorkflowTemplate(TemplateCode);

-- Check Constraints
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_WorkflowType 
    CHECK (WorkflowType IN ('New Supplier Qualification', 'Periodic Assessment', 'Triggered Review', 
                           'Development Program', 'Re-qualification', 'Audit', 'Capability Assessment'));
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_WorkflowCategory 
    CHECK (WorkflowCategory IN ('Initial', 'Periodic', 'Triggered', 'Emergency', 'Development', 'Audit', 'Special'));
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_Priority 
    CHECK (Priority IN ('Low', 'Medium', 'High', 'Urgent'));
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_OverallStatus 
    CHECK (OverallStatus IN ('Draft', 'Initiated', 'In Progress', 'Under Review', 'Approved', 
                             'Rejected', 'On Hold', 'Cancelled', 'Completed'));
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_RecommendedAction 
    CHECK (RecommendedAction IN ('Approve', 'Reject', 'Conditional Approval', 'Defer', 'Request More Info') OR RecommendedAction IS NULL);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_QualificationDecision 
    CHECK (QualificationDecision IN ('Qualified', 'Not Qualified', 'Conditionally Qualified', 
                                     'Under Development', 'Disqualified') OR QualificationDecision IS NULL);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_QualificationLevel 
    CHECK (QualificationLevel IN ('Tier 1', 'Tier 2', 'Tier 3', 'Development', 'Strategic', 'Preferred') OR QualificationLevel IS NULL);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_ConfidentialityLevel 
    CHECK (ConfidentialityLevel IN ('Public', 'Standard', 'Confidential', 'Restricted'));

-- Business Rules
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_PlannedDates 
    CHECK (PlannedEndDate IS NULL OR PlannedStartDate IS NULL OR PlannedEndDate >= PlannedStartDate);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_ActualDates 
    CHECK (ActualEndDate IS NULL OR ActualStartDate IS NULL OR ActualEndDate >= ActualStartDate);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_QualityGates 
    CHECK (QualityGatesPassed <= QualityGatesTotal);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_Documents 
    CHECK (DocumentsReceived <= DocumentsRequired);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_ReviewDate 
    CHECK (ReviewDate IS NULL OR ReviewDate >= CreatedDate);
ALTER TABLE AssessmentWorkflow ADD CONSTRAINT CK_AssessmentWorkflow_ApprovalDate 
    CHECK (ApprovalDate IS NULL OR ApprovalDate >= CreatedDate);
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_AssessmentWorkflow_SupplierId ON AssessmentWorkflow(SupplierId);
CREATE INDEX IX_AssessmentWorkflow_CategoryId ON AssessmentWorkflow(CategoryId);
CREATE INDEX IX_AssessmentWorkflow_InitiatingUserId ON AssessmentWorkflow(InitiatingUserId);
CREATE INDEX IX_AssessmentWorkflow_AssignedUserId ON AssessmentWorkflow(AssignedUserId);
CREATE INDEX IX_AssessmentWorkflow_ReviewerUserId ON AssessmentWorkflow(ReviewerUserId);
CREATE INDEX IX_AssessmentWorkflow_ApproverUserId ON AssessmentWorkflow(ApproverUserId);
CREATE INDEX IX_AssessmentWorkflow_CostCurrency ON AssessmentWorkflow(CostCurrency);
CREATE INDEX IX_AssessmentWorkflow_WorkflowTemplate ON AssessmentWorkflow(WorkflowTemplate);

-- Status and Priority Indexes
CREATE INDEX IX_AssessmentWorkflow_OverallStatus ON AssessmentWorkflow(OverallStatus);
CREATE INDEX IX_AssessmentWorkflow_Priority ON AssessmentWorkflow(Priority);
CREATE INDEX IX_AssessmentWorkflow_CurrentStage ON AssessmentWorkflow(CurrentStage);

-- Type and Category Indexes
CREATE INDEX IX_AssessmentWorkflow_WorkflowType ON AssessmentWorkflow(WorkflowType);
CREATE INDEX IX_AssessmentWorkflow_WorkflowCategory ON AssessmentWorkflow(WorkflowCategory);

-- Date-based Indexes
CREATE INDEX IX_AssessmentWorkflow_PlannedStartDate ON AssessmentWorkflow(PlannedStartDate);
CREATE INDEX IX_AssessmentWorkflow_PlannedEndDate ON AssessmentWorkflow(PlannedEndDate);
CREATE INDEX IX_AssessmentWorkflow_NextMilestoneDate ON AssessmentWorkflow(NextMilestoneDate);
CREATE INDEX IX_AssessmentWorkflow_NextAssessmentDate ON AssessmentWorkflow(NextAssessmentDate);
CREATE INDEX IX_AssessmentWorkflow_CreatedDate ON AssessmentWorkflow(CreatedDate DESC);

-- Score and Performance Indexes
CREATE INDEX IX_AssessmentWorkflow_OverallScore ON AssessmentWorkflow(OverallScore DESC);
CREATE INDEX IX_AssessmentWorkflow_CompletionPercentage ON AssessmentWorkflow(CompletionPercentage DESC);
CREATE INDEX IX_AssessmentWorkflow_ROIProjection ON AssessmentWorkflow(ROIProjection DESC);

-- Decision and Approval Indexes
CREATE INDEX IX_AssessmentWorkflow_QualificationDecision ON AssessmentWorkflow(QualificationDecision);
CREATE INDEX IX_AssessmentWorkflow_ApprovalDate ON AssessmentWorkflow(ApprovalDate DESC);

-- Boolean Flag Indexes
CREATE INDEX IX_AssessmentWorkflow_IsActive ON AssessmentWorkflow(IsActive);
CREATE INDEX IX_AssessmentWorkflow_IsRecurring ON AssessmentWorkflow(IsRecurring);

-- Escalation Index
CREATE INDEX IX_AssessmentWorkflow_EscalationLevel ON AssessmentWorkflow(EscalationLevel);

-- Composite Indexes for Common Queries
CREATE INDEX IX_AssessmentWorkflow_Status_Priority ON AssessmentWorkflow(OverallStatus, Priority);
CREATE INDEX IX_AssessmentWorkflow_Supplier_Status ON AssessmentWorkflow(SupplierId, OverallStatus);
CREATE INDEX IX_AssessmentWorkflow_Assigned_Status ON AssessmentWorkflow(AssignedUserId, OverallStatus);
CREATE INDEX IX_AssessmentWorkflow_Type_Status ON AssessmentWorkflow(WorkflowType, OverallStatus);
CREATE INDEX IX_AssessmentWorkflow_Active_Milestone ON AssessmentWorkflow(IsActive, NextMilestoneDate);
```

---

## Entity: WorkflowStage

### Purpose
Defines workflow stages and tracks progress through structured assessment processes.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| StageId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| WorkflowId | BIGINT | FK, NOT NULL | Reference to assessment workflow |
| StageCode | VARCHAR(50) | NOT NULL | Stage identifier code |
| StageName | VARCHAR(255) | NOT NULL | Stage display name |
| StageDescription | TEXT | NULL | Detailed stage description |
| StageSequence | INT | NOT NULL, CHECK > 0 | Stage order in workflow |
| StageType | VARCHAR(20) | NOT NULL | Document Review, Site Visit, etc. |
| IsRequired | BOOLEAN | NOT NULL, DEFAULT TRUE | Required stage flag |
| IsCritical | BOOLEAN | NOT NULL, DEFAULT FALSE | Critical path stage flag |
| Prerequisites | TEXT | NULL | Stage prerequisites |
| DeliverableRequirements | TEXT | NULL | Required deliverables |
| AcceptanceCriteria | TEXT | NULL | Stage completion criteria |
| EstimatedDuration | INT | NULL, CHECK >= 0 | Estimated duration in days |
| EstimatedEffort | DECIMAL(8,2) | NULL, CHECK >= 0 | Estimated effort in hours |
| PlannedStartDate | DATE | NULL | Planned stage start |
| PlannedEndDate | DATE | NULL | Planned stage completion |
| ActualStartDate | DATE | NULL | Actual stage start |
| ActualEndDate | DATE | NULL | Actual stage completion |
| Status | VARCHAR(20) | NOT NULL, DEFAULT 'Not Started' | Stage status |
| CompletionPercentage | DECIMAL(5,2) | NOT NULL, DEFAULT 0.00, CHECK 0.00-100.00 | Completion percentage |
| AssignedUserId | VARCHAR(50) | FK, NULL | User assigned to stage |
| ResponsibleParty | VARCHAR(100) | NULL | Responsible party |
| StageScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Stage assessment score |
| WeightInOverall | DECIMAL(5,4) | NOT NULL, DEFAULT 1.0000, CHECK 0.0000-1.0000 | Weight in overall score |
| PassingScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Minimum passing score |
| MaximumScore | DECIMAL(5,2) | NOT NULL, DEFAULT 100.00, CHECK > 0 | Maximum possible score |
| QualityGateRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Quality gate required flag |
| QualityGatePassed | BOOLEAN | NULL | Quality gate status |
| QualityGateComments | TEXT | NULL | Quality gate comments |
| DocumentsRequired | TEXT | NULL | Required documents list |
| DocumentsReceived | TEXT | NULL | Received documents list |
| SiteVisitRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Site visit required flag |
| SiteVisitCompleted | BOOLEAN | NULL | Site visit completion status |
| InterviewRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Interview required flag |
| InterviewCompleted | BOOLEAN | NULL | Interview completion status |
| TestingRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Testing required flag |
| TestingCompleted | BOOLEAN | NULL | Testing completion status |
| VerificationRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Verification required flag |
| VerificationCompleted | BOOLEAN | NULL | Verification completion status |
| ApprovalRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Stage approval required |
| ApprovedBy | VARCHAR(50) | FK, NULL | Approving user |
| ApprovalDate | TIMESTAMP | NULL | Approval timestamp |
| ApprovalComments | TEXT | NULL | Approval comments |
| RejectionReason | TEXT | NULL | Rejection reason |
| IssuesIdentified | TEXT | NULL | Issues found in stage |
| ResolutionActions | TEXT | NULL | Issue resolution actions |
| RisksIdentified | TEXT | NULL | Risks identified |
| MitigationActions | TEXT | NULL | Risk mitigation actions |
| Observations | TEXT | NULL | Stage observations |
| Recommendations | TEXT | NULL | Stage recommendations |
| NextStepActions | TEXT | NULL | Required next actions |
| StakeholdersInvolved | TEXT | NULL | Key stakeholders |
| CommunicationPlan | TEXT | NULL | Communication requirements |
| TrainingRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Training required flag |
| CertificationRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Certification required flag |
| ExternalResourcesNeeded | TEXT | NULL | External resources required |
| BudgetAllocation | DECIMAL(15,2) | NULL, CHECK >= 0 | Budget allocated to stage |
| ActualCost | DECIMAL(15,2) | NULL, CHECK >= 0 | Actual cost incurred |
| CostCurrency | VARCHAR(3) | FK, NULL | Cost currency |
| ROIContribution | DECIMAL(5,2) | NULL | Stage ROI contribution |
| CustomerImpact | TEXT | NULL | Customer impact assessment |
| BusinessValue | TEXT | NULL | Business value delivered |
| LessonsLearned | TEXT | NULL | Lessons learned |
| BestPractices | TEXT | NULL | Best practices identified |
| ProcessImprovements | TEXT | NULL | Process improvement suggestions |
| EscalationTriggers | TEXT | NULL | Escalation trigger conditions |
| EscalationProcedure | TEXT | NULL | Escalation procedure |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE WorkflowStage ADD CONSTRAINT PK_WorkflowStage PRIMARY KEY (StageId);

-- Foreign Keys
ALTER TABLE WorkflowStage ADD CONSTRAINT FK_WorkflowStage_Workflow 
    FOREIGN KEY (WorkflowId) REFERENCES AssessmentWorkflow(WorkflowId) ON DELETE CASCADE;
ALTER TABLE WorkflowStage ADD CONSTRAINT FK_WorkflowStage_AssignedUser 
    FOREIGN KEY (AssignedUserId) REFERENCES UserProfile(UserId);
ALTER TABLE WorkflowStage ADD CONSTRAINT FK_WorkflowStage_ApprovedBy 
    FOREIGN KEY (ApprovedBy) REFERENCES UserProfile(UserId);
ALTER TABLE WorkflowStage ADD CONSTRAINT FK_WorkflowStage_CostCurrency 
    FOREIGN KEY (CostCurrency) REFERENCES Currency(CurrencyCode);

-- Unique Constraint for Workflow-Sequence combination
ALTER TABLE WorkflowStage ADD CONSTRAINT UK_WorkflowStage_WorkflowSequence 
    UNIQUE (WorkflowId, StageSequence);

-- Check Constraints
ALTER TABLE WorkflowStage ADD CONSTRAINT CK_WorkflowStage_StageType 
    CHECK (StageType IN ('Initial Review', 'Document Review', 'Site Visit', 'Technical Assessment', 
                        'Financial Review', 'Capability Assessment', 'Quality Audit', 'Compliance Review',
                        'Reference Check', 'Interview', 'Testing', 'Final Review', 'Approval'));
ALTER TABLE WorkflowStage ADD CONSTRAINT CK_WorkflowStage_Status 
    CHECK (Status IN ('Not Started', 'In Progress', 'On Hold', 'Completed', 'Failed', 'Skipped', 'Cancelled'));

-- Business Rules
ALTER TABLE WorkflowStage ADD CONSTRAINT CK_WorkflowStage_PlannedDates 
    CHECK (PlannedEndDate IS NULL OR PlannedStartDate IS NULL OR PlannedEndDate >= PlannedStartDate);
ALTER TABLE WorkflowStage ADD CONSTRAINT CK_WorkflowStage_ActualDates 
    CHECK (ActualEndDate IS NULL OR ActualStartDate IS NULL OR ActualEndDate >= ActualStartDate);
ALTER TABLE WorkflowStage ADD CONSTRAINT CK_WorkflowStage_Scores 
    CHECK (StageScore IS NULL OR StageScore <= MaximumScore);
ALTER TABLE WorkflowStage ADD CONSTRAINT CK_WorkflowStage_PassingScore 
    CHECK (PassingScore IS NULL OR PassingScore <= MaximumScore);
ALTER TABLE WorkflowStage ADD CONSTRAINT CK_WorkflowStage_QualityGate 
    CHECK (QualityGatePassed IS NULL OR QualityGateRequired = 1);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_WorkflowStage_WorkflowId ON WorkflowStage(WorkflowId);
CREATE INDEX IX_WorkflowStage_AssignedUserId ON WorkflowStage(AssignedUserId);
CREATE INDEX IX_WorkflowStage_ApprovedBy ON WorkflowStage(ApprovedBy);
CREATE INDEX IX_WorkflowStage_CostCurrency ON WorkflowStage(CostCurrency);

-- Unique Key Index (automatically created)

-- Stage Management Indexes
CREATE INDEX IX_WorkflowStage_StageSequence ON WorkflowStage(StageSequence);
CREATE INDEX IX_WorkflowStage_Status ON WorkflowStage(Status);
CREATE INDEX IX_WorkflowStage_StageType ON WorkflowStage(StageType);

-- Date-based Indexes
CREATE INDEX IX_WorkflowStage_PlannedStartDate ON WorkflowStage(PlannedStartDate);
CREATE INDEX IX_WorkflowStage_PlannedEndDate ON WorkflowStage(PlannedEndDate);
CREATE INDEX IX_WorkflowStage_ActualEndDate ON WorkflowStage(ActualEndDate DESC);

-- Performance Indexes
CREATE INDEX IX_WorkflowStage_StageScore ON WorkflowStage(StageScore DESC);
CREATE INDEX IX_WorkflowStage_CompletionPercentage ON WorkflowStage(CompletionPercentage DESC);

-- Boolean Flag Indexes
CREATE INDEX IX_WorkflowStage_IsRequired ON WorkflowStage(IsRequired);
CREATE INDEX IX_WorkflowStage_IsCritical ON WorkflowStage(IsCritical);
CREATE INDEX IX_WorkflowStage_QualityGateRequired ON WorkflowStage(QualityGateRequired);

-- Composite Indexes
CREATE INDEX IX_WorkflowStage_Workflow_Sequence ON WorkflowStage(WorkflowId, StageSequence);
CREATE INDEX IX_WorkflowStage_Status_Priority ON WorkflowStage(Status, IsCritical DESC);
CREATE INDEX IX_WorkflowStage_Assigned_Status ON WorkflowStage(AssignedUserId, Status);
```

---

## Entity: WorkflowTemplate

### Purpose
Defines reusable workflow templates for consistent assessment processes across different scenarios.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| TemplateId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| TemplateCode | VARCHAR(50) | UK, NOT NULL | Template identifier code |
| TemplateName | VARCHAR(255) | NOT NULL | Template display name |
| TemplateDescription | TEXT | NOT NULL | Detailed template description |
| TemplateVersion | VARCHAR(20) | NOT NULL, DEFAULT '1.0' | Template version |
| TemplateType | VARCHAR(30) | NOT NULL | Qualification, Assessment, etc. |
| TemplateCategory | VARCHAR(30) | NOT NULL | Standard, Custom, Industry-specific |
| ApplicableIndustries | TEXT | NULL | Industries where template applies |
| ApplicableCategories | TEXT | NULL | Product categories (JSON array) |
| ApplicableRegions | TEXT | NULL | Geographic regions (JSON array) |
| SupplierTypes | TEXT | NULL | Applicable supplier types |
| MinimumRiskLevel | VARCHAR(10) | NULL | Minimum risk level for template |
| MaximumRiskLevel | VARCHAR(10) | NULL | Maximum risk level for template |
| ComplexityLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Medium' | Low, Medium, High |
| EstimatedDuration | INT | NULL, CHECK > 0 | Estimated duration in days |
| EstimatedEffort | DECIMAL(8,2) | NULL, CHECK >= 0 | Estimated effort in hours |
| EstimatedCost | DECIMAL(15,2) | NULL, CHECK >= 0 | Estimated cost |
| CostCurrency | VARCHAR(3) | FK, NULL | Cost currency |
| TotalStages | INT | NOT NULL, DEFAULT 1, CHECK > 0 | Total number of stages |
| CriticalStages | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Number of critical stages |
| QualityGatesRequired | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Quality gates required |
| DocumentsRequired | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Documents required |
| SiteVisitsRequired | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Site visits required |
| InterviewsRequired | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Interviews required |
| TestsRequired | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Tests required |
| ReferenceChecksRequired | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Reference checks required |
| ApprovalLevelsRequired | INT | NOT NULL, DEFAULT 1, CHECK > 0 | Approval levels required |
| StakeholderRoles | TEXT | NULL | Required stakeholder roles |
| SkillsRequired | TEXT | NULL | Skills required for execution |
| ResourceRequirements | TEXT | NULL | Resource requirements |
| Prerequisites | TEXT | NULL | Template prerequisites |
| BusinessJustification | TEXT | NULL | Template business case |
| RegulatoryRequirements | TEXT | NULL | Regulatory compliance requirements |
| ComplianceStandards | TEXT | NULL | Compliance standards to meet |
| QualityStandards | TEXT | NULL | Quality standards requirements |
| SuccessCriteria | TEXT | NULL | Success measurement criteria |
| RiskMitigationGuidelines | TEXT | NULL | Risk mitigation guidelines |
| CommunicationPlan | TEXT | NULL | Communication requirements |
| TrainingRequirements | TEXT | NULL | Training requirements |
| ToolsRequired | TEXT | NULL | Tools and systems required |
| TemplateUsage | TEXT | NULL | Usage instructions |
| BestPractices | TEXT | NULL | Best practices guidance |
| CommonPitfalls | TEXT | NULL | Common pitfalls to avoid |
| CustomizationOptions | TEXT | NULL | Customization guidelines |
| IntegrationPoints | TEXT | NULL | System integration points |
| ReportingRequirements | TEXT | NULL | Reporting requirements |
| AuditTrailRequirements | TEXT | NULL | Audit trail requirements |
| RetentionRequirements | TEXT | NULL | Data retention requirements |
| CreatedBy | VARCHAR(50) | NOT NULL | Template creator |
| ReviewedBy | VARCHAR(50) | FK, NULL | Template reviewer |
| ApprovedBy | VARCHAR(50) | FK, NULL | Template approver |
| ApprovedDate | TIMESTAMP | NULL | Template approval date |
| EffectiveDate | DATE | NOT NULL | Template effective date |
| ExpirationDate | DATE | NULL | Template expiration date |
| LastRevisionDate | DATE | NULL | Last revision date |
| NextReviewDate | DATE | NULL | Next scheduled review |
| UsageCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Times template has been used |
| SuccessRate | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Template success rate %|
| AverageDuration | DECIMAL(8,2) | NULL, CHECK >= 0 | Average actual duration |
| AverageScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | Average assessment score |
| FeedbackScore | DECIMAL(5,2) | NULL, CHECK 0.00-100.00 | User feedback score |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active template flag |
| IsDefault | BOOLEAN | NOT NULL, DEFAULT FALSE | Default template flag |
| IsCustomizable | BOOLEAN | NOT NULL, DEFAULT TRUE | Customizable template flag |
| RequiresApproval | BOOLEAN | NOT NULL, DEFAULT TRUE | Approval required flag |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE WorkflowTemplate ADD CONSTRAINT PK_WorkflowTemplate PRIMARY KEY (TemplateId);

-- Unique Constraints
ALTER TABLE WorkflowTemplate ADD CONSTRAINT UK_WorkflowTemplate_TemplateCode UNIQUE (TemplateCode);

-- Foreign Keys
ALTER TABLE WorkflowTemplate ADD CONSTRAINT FK_WorkflowTemplate_CostCurrency 
    FOREIGN KEY (CostCurrency) REFERENCES Currency(CurrencyCode);
ALTER TABLE WorkflowTemplate ADD CONSTRAINT FK_WorkflowTemplate_ReviewedBy 
    FOREIGN KEY (ReviewedBy) REFERENCES UserProfile(UserId);
ALTER TABLE WorkflowTemplate ADD CONSTRAINT FK_WorkflowTemplate_ApprovedBy 
    FOREIGN KEY (ApprovedBy) REFERENCES UserProfile(UserId);

-- Check Constraints
ALTER TABLE WorkflowTemplate ADD CONSTRAINT CK_WorkflowTemplate_TemplateType 
    CHECK (TemplateType IN ('New Supplier Qualification', 'Periodic Assessment', 'Development Program', 
                           'Audit Template', 'Capability Assessment', 'Risk Assessment', 'Custom'));
ALTER TABLE WorkflowTemplate ADD CONSTRAINT CK_WorkflowTemplate_TemplateCategory 
    CHECK (TemplateCategory IN ('Standard', 'Custom', 'Industry-Specific', 'Region-Specific', 'Category-Specific'));
ALTER TABLE WorkflowTemplate ADD CONSTRAINT CK_WorkflowTemplate_ComplexityLevel 
    CHECK (ComplexityLevel IN ('Low', 'Medium', 'High', 'Very High'));
ALTER TABLE WorkflowTemplate ADD CONSTRAINT CK_WorkflowTemplate_RiskLevels 
    CHECK (MinimumRiskLevel IN ('Low', 'Medium', 'High', 'Critical') OR MinimumRiskLevel IS NULL);

-- Business Rules
ALTER TABLE WorkflowTemplate ADD CONSTRAINT CK_WorkflowTemplate_CriticalStages 
    CHECK (CriticalStages <= TotalStages);
ALTER TABLE WorkflowTemplate ADD CONSTRAINT CK_WorkflowTemplate_ExpirationDate 
    CHECK (ExpirationDate IS NULL OR ExpirationDate > EffectiveDate);
ALTER TABLE WorkflowTemplate ADD CONSTRAINT CK_WorkflowTemplate_ApprovalDate 
    CHECK (ApprovedDate IS NULL OR ApprovedDate <= EffectiveDate);
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_WorkflowTemplate_CostCurrency ON WorkflowTemplate(CostCurrency);
CREATE INDEX IX_WorkflowTemplate_ReviewedBy ON WorkflowTemplate(ReviewedBy);
CREATE INDEX IX_WorkflowTemplate_ApprovedBy ON WorkflowTemplate(ApprovedBy);

-- Classification Indexes
CREATE INDEX IX_WorkflowTemplate_TemplateType ON WorkflowTemplate(TemplateType);
CREATE INDEX IX_WorkflowTemplate_TemplateCategory ON WorkflowTemplate(TemplateCategory);
CREATE INDEX IX_WorkflowTemplate_ComplexityLevel ON WorkflowTemplate(ComplexityLevel);

-- Date-based Indexes
CREATE INDEX IX_WorkflowTemplate_EffectiveDate ON WorkflowTemplate(EffectiveDate DESC);
CREATE INDEX IX_WorkflowTemplate_ExpirationDate ON WorkflowTemplate(ExpirationDate);
CREATE INDEX IX_WorkflowTemplate_NextReviewDate ON WorkflowTemplate(NextReviewDate);

-- Performance Indexes
CREATE INDEX IX_WorkflowTemplate_UsageCount ON WorkflowTemplate(UsageCount DESC);
CREATE INDEX IX_WorkflowTemplate_SuccessRate ON WorkflowTemplate(SuccessRate DESC);
CREATE INDEX IX_WorkflowTemplate_FeedbackScore ON WorkflowTemplate(FeedbackScore DESC);

-- Boolean Flag Indexes
CREATE INDEX IX_WorkflowTemplate_IsActive ON WorkflowTemplate(IsActive);
CREATE INDEX IX_WorkflowTemplate_IsDefault ON WorkflowTemplate(IsDefault);

-- Composite Indexes
CREATE INDEX IX_WorkflowTemplate_Active_Type ON WorkflowTemplate(IsActive, TemplateType);
CREATE INDEX IX_WorkflowTemplate_Category_Complexity ON WorkflowTemplate(TemplateCategory, ComplexityLevel);
```

---

## Business Rules and Calculations

### Workflow Progress Calculation

```sql
-- Function to calculate workflow progress
CREATE FUNCTION CalculateWorkflowProgress(@WorkflowId BIGINT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @Progress DECIMAL(5,2);
    DECLARE @TotalStages INT;
    DECLARE @CompletedStages INT;
    DECLARE @InProgressWeight DECIMAL(5,2) = 0.5; -- In-progress stages count as 50%
    
    SELECT 
        @TotalStages = COUNT(*),
        @CompletedStages = SUM(
            CASE 
                WHEN Status = 'Completed' THEN 1
                WHEN Status = 'In Progress' THEN @InProgressWeight
                ELSE 0
            END
        )
    FROM WorkflowStage
    WHERE WorkflowId = @WorkflowId
      AND IsRequired = 1;
    
    IF @TotalStages > 0
        SET @Progress = (@CompletedStages / @TotalStages) * 100;
    ELSE
        SET @Progress = 0;
    
    RETURN @Progress;
END;
```

### Workflow Score Calculation

```sql
-- Function to calculate weighted workflow score
CREATE FUNCTION CalculateWorkflowScore(@WorkflowId BIGINT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @WeightedScore DECIMAL(5,2);
    
    SELECT @WeightedScore = SUM(StageScore * WeightInOverall) / SUM(WeightInOverall)
    FROM WorkflowStage
    WHERE WorkflowId = @WorkflowId
      AND Status = 'Completed'
      AND StageScore IS NOT NULL
      AND IsRequired = 1;
    
    RETURN ISNULL(@WeightedScore, 0);
END;
```

### Workflow SLA Monitoring

```sql
-- Stored procedure to monitor workflow SLAs and generate alerts
CREATE PROCEDURE MonitorWorkflowSLAs
AS
BEGIN
    -- Alert for overdue workflows
    INSERT INTO RiskAlertHistory (
        AlertType, AlertLevel, AlertTitle, AlertDescription, 
        AlertDate, DetectedBy, Status, AssignedTo
    )
    SELECT 
        'Workflow Overdue',
        CASE 
            WHEN DATEDIFF(day, aw.PlannedEndDate, GETDATE()) > 14 THEN 'Critical'
            WHEN DATEDIFF(day, aw.PlannedEndDate, GETDATE()) > 7 THEN 'High'
            ELSE 'Medium'
        END,
        'Assessment Workflow Overdue',
        'Workflow ' + aw.WorkflowCode + ' is ' + CAST(DATEDIFF(day, aw.PlannedEndDate, GETDATE()) AS VARCHAR(10)) + ' days overdue',
        GETDATE(),
        'System',
        'Open',
        aw.AssignedUserId
    FROM AssessmentWorkflow aw
    WHERE aw.OverallStatus IN ('In Progress', 'Under Review')
      AND aw.PlannedEndDate < GETDATE()
      AND aw.IsActive = 1;
      
    -- Alert for upcoming milestones
    INSERT INTO RiskAlertHistory (
        AlertType, AlertLevel, AlertTitle, AlertDescription,
        AlertDate, DetectedBy, Status, AssignedTo
    )
    SELECT 
        'Milestone Due',
        'Medium',
        'Workflow Milestone Due Soon',
        'Milestone "' + aw.NextMilestone + '" for workflow ' + aw.WorkflowCode + ' is due in ' + 
        CAST(DATEDIFF(day, GETDATE(), aw.NextMilestoneDate) AS VARCHAR(5)) + ' days',
        GETDATE(),
        'System',
        'Open',
        aw.AssignedUserId
    FROM AssessmentWorkflow aw
    WHERE aw.NextMilestoneDate BETWEEN GETDATE() AND DATEADD(day, 3, GETDATE())
      AND aw.OverallStatus IN ('In Progress', 'Under Review')
      AND aw.IsActive = 1;
END;
```

### Template Performance Analysis

```sql
-- Stored procedure to analyze template performance
CREATE PROCEDURE AnalyzeTemplatePerformance(@TemplateCode VARCHAR(50))
AS
BEGIN
    SELECT 
        wt.TemplateCode,
        wt.TemplateName,
        COUNT(aw.WorkflowId) AS TotalUsage,
        AVG(DATEDIFF(day, aw.ActualStartDate, aw.ActualEndDate)) AS AverageDurationDays,
        AVG(aw.OverallScore) AS AverageScore,
        COUNT(CASE WHEN aw.QualificationDecision = 'Qualified' THEN 1 END) AS QualifiedCount,
        COUNT(CASE WHEN aw.QualificationDecision = 'Not Qualified' THEN 1 END) AS NotQualifiedCount,
        CAST(COUNT(CASE WHEN aw.QualificationDecision = 'Qualified' THEN 1 END) AS DECIMAL) / 
        COUNT(aw.WorkflowId) * 100 AS SuccessRate,
        AVG(aw.EstimatedDuration) AS PlannedDuration,
        AVG(DATEDIFF(day, aw.ActualStartDate, aw.ActualEndDate)) - AVG(aw.EstimatedDuration) AS DurationVariance
    FROM WorkflowTemplate wt
    LEFT JOIN AssessmentWorkflow aw ON wt.TemplateCode = aw.WorkflowTemplate
    WHERE wt.TemplateCode = @TemplateCode
      AND aw.OverallStatus = 'Completed'
    GROUP BY wt.TemplateCode, wt.TemplateName;
END;
```

---

## Data Quality Rules

### Assessment Workflow Management
- Workflows must have clearly defined objectives and success criteria
- Stage sequences must be logically ordered and consistent
- All required stages must be completed before workflow completion
- Quality gates must be passed for critical stages

### Workflow Template Management
- Templates must be reviewed and approved before activation
- Template effectiveness must be measured and tracked
- Templates should be updated based on performance feedback
- Inactive templates should be archived with usage history

### Stage Management
- Stage prerequisites must be met before stage activation
- Required deliverables must be clearly defined
- Approval workflows must be followed for critical stages
- Issue resolution must be documented and tracked

---

*Document Version*: 1.0  
*Last Updated*: August 21, 2025  
*Next Review*: September 21, 2025  
*Document Owner*: Supplier Development Team
