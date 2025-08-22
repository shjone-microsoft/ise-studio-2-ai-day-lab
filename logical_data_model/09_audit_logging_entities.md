# Audit Logging Entities - Logical Data Model

## Overview
This document defines the logical structure for comprehensive audit trails, data change tracking, and system event logging for compliance, security monitoring, and operational intelligence.

---

## Entity: AuditLog

### Purpose
Master audit log for all system events, data changes, and user activities with immutable record keeping for compliance and forensic analysis.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| AuditLogId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| EventId | VARCHAR(50) | UK, NOT NULL | Unique event identifier |
| EventTimestamp | TIMESTAMP | NOT NULL | Event occurrence timestamp |
| EventType | VARCHAR(50) | NOT NULL | Create, Update, Delete, Login, etc. |
| EventCategory | VARCHAR(30) | NOT NULL | Data, Security, System, Business |
| EventSeverity | VARCHAR(10) | NOT NULL, DEFAULT 'Info' | Event severity level |
| EventSource | VARCHAR(100) | NOT NULL | Source system or component |
| EventSourceVersion | VARCHAR(20) | NULL | Source system version |
| UserId | VARCHAR(50) | FK, NULL | User who initiated event |
| SessionId | VARCHAR(128) | FK, NULL | Session context |
| ImpersonatedUserId | VARCHAR(50) | FK, NULL | Impersonated user if applicable |
| ServiceAccount | VARCHAR(100) | NULL | Service account if system event |
| ApplicationName | VARCHAR(100) | NOT NULL | Application name |
| ApplicationVersion | VARCHAR(20) | NULL | Application version |
| ModuleName | VARCHAR(100) | NULL | System module or component |
| FunctionName | VARCHAR(255) | NULL | Function or method name |
| ProcessId | VARCHAR(50) | NULL | Process or transaction ID |
| ThreadId | VARCHAR(50) | NULL | Thread identifier |
| CorrelationId | VARCHAR(100) | NULL | Correlation identifier |
| ParentEventId | VARCHAR(50) | FK, NULL | Parent event reference |
| RootEventId | VARCHAR(50) | FK, NULL | Root event in chain |
| EventSequence | BIGINT | NOT NULL | Event sequence number |
| BatchId | VARCHAR(100) | NULL | Batch operation identifier |
| TransactionId | VARCHAR(100) | NULL | Database transaction ID |
| EntityType | VARCHAR(50) | NULL | Affected entity type |
| EntityId | VARCHAR(100) | NULL | Affected entity identifier |
| EntityName | VARCHAR(255) | NULL | Entity display name |
| EntityVersion | VARCHAR(20) | NULL | Entity version |
| TableName | VARCHAR(128) | NULL | Database table name |
| SchemaName | VARCHAR(128) | NULL | Database schema name |
| DatabaseName | VARCHAR(128) | NULL | Database name |
| ActionPerformed | VARCHAR(100) | NOT NULL | Specific action performed |
| ActionContext | TEXT | NULL | Action context details |
| BusinessProcess | VARCHAR(100) | NULL | Business process context |
| BusinessReason | TEXT | NULL | Business justification |
| WorkflowId | BIGINT | FK, NULL | Associated workflow |
| WorkflowStep | VARCHAR(100) | NULL | Workflow step |
| ApprovalRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Approval required flag |
| ApprovalStatus | VARCHAR(20) | NULL | Approval status |
| ApprovedBy | VARCHAR(50) | FK, NULL | Approving user |
| ApprovalTimestamp | TIMESTAMP | NULL | Approval timestamp |
| DataBefore | TEXT | NULL | Data state before change |
| DataAfter | TEXT | NULL | Data state after change |
| DataDelta | TEXT | NULL | Change delta (JSON) |
| FieldsChanged | TEXT | NULL | Changed fields (JSON array) |
| FieldCount | INT | NULL, CHECK >= 0 | Number of fields changed |
| RecordsAffected | INT | NULL, CHECK >= 0 | Records affected |
| Success | BOOLEAN | NOT NULL, DEFAULT TRUE | Event success flag |
| ErrorCode | VARCHAR(50) | NULL | Error code if applicable |
| ErrorMessage | TEXT | NULL | Error message |
| ErrorDetails | TEXT | NULL | Detailed error information |
| WarningCode | VARCHAR(50) | NULL | Warning code |
| WarningMessage | TEXT | NULL | Warning message |
| ExceptionType | VARCHAR(255) | NULL | Exception type |
| ExceptionStackTrace | TEXT | NULL | Exception stack trace |
| PerformanceMetrics | TEXT | NULL | Performance metrics (JSON) |
| ExecutionTimeMs | INT | NULL, CHECK >= 0 | Execution time in milliseconds |
| MemoryUsageMB | DECIMAL(10,2) | NULL, CHECK >= 0 | Memory usage in MB |
| CPUUsagePercent | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | CPU usage percentage |
| DatabaseConnections | INT | NULL, CHECK >= 0 | Database connections used |
| NetworkCallsCount | INT | NULL, CHECK >= 0 | Network calls made |
| CacheHitRatio | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Cache hit ratio |
| IPAddress | VARCHAR(45) | NULL | Client IP address |
| UserAgent | VARCHAR(1000) | NULL | Client user agent |
| RequestMethod | VARCHAR(10) | NULL | HTTP method |
| RequestURL | VARCHAR(2000) | NULL | Request URL |
| RequestHeaders | TEXT | NULL | Request headers (JSON) |
| RequestBody | TEXT | NULL | Request body |
| ResponseCode | INT | NULL, CHECK >= 0 | HTTP response code |
| ResponseHeaders | TEXT | NULL | Response headers (JSON) |
| ResponseBody | TEXT | NULL | Response body |
| ResponseSize | BIGINT | NULL, CHECK >= 0 | Response size in bytes |
| LocationCity | VARCHAR(100) | NULL | Geographic location (city) |
| LocationRegion | VARCHAR(100) | NULL | Geographic location (region) |
| LocationCountry | VARCHAR(100) | NULL | Geographic location (country) |
| LocationCoordinates | VARCHAR(50) | NULL | GPS coordinates |
| DeviceType | VARCHAR(50) | NULL | Device type |
| DeviceOS | VARCHAR(100) | NULL | Operating system |
| DeviceId | VARCHAR(255) | NULL | Device identifier |
| BrowserName | VARCHAR(100) | NULL | Browser name |
| BrowserVersion | VARCHAR(50) | NULL | Browser version |
| SecurityContext | TEXT | NULL | Security context (JSON) |
| SecurityLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Normal' | Security classification |
| DataClassification | VARCHAR(20) | NOT NULL, DEFAULT 'Internal' | Data classification |
| ComplianceRelevant | BOOLEAN | NOT NULL, DEFAULT FALSE | Compliance relevance |
| RegulatoryFramework | VARCHAR(100) | NULL | Applicable regulatory framework |
| RetentionPeriod | INT | NOT NULL, DEFAULT 2555, CHECK > 0 | Retention period in days |
| RetentionReason | VARCHAR(255) | NULL | Retention justification |
| LegalHoldFlag | BOOLEAN | NOT NULL, DEFAULT FALSE | Legal hold flag |
| LegalHoldId | VARCHAR(100) | NULL | Legal hold identifier |
| PrivacyImpact | BOOLEAN | NOT NULL, DEFAULT FALSE | Privacy impact flag |
| PersonalDataInvolved | BOOLEAN | NOT NULL, DEFAULT FALSE | Personal data involved |
| SensitiveDataInvolved | BOOLEAN | NOT NULL, DEFAULT FALSE | Sensitive data involved |
| DataSubjectId | VARCHAR(100) | NULL | Data subject identifier |
| ConsentRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Consent required flag |
| ConsentStatus | VARCHAR(20) | NULL | Consent status |
| DataProcessingPurpose | VARCHAR(255) | NULL | Data processing purpose |
| DataProcessingLegalBasis | VARCHAR(255) | NULL | Legal basis for processing |
| CrossBorderTransfer | BOOLEAN | NOT NULL, DEFAULT FALSE | Cross-border data transfer |
| TransferMechanism | VARCHAR(100) | NULL | Transfer mechanism |
| DestinationCountry | VARCHAR(100) | NULL | Destination country |
| AdequacyDecision | BOOLEAN | NULL | Adequacy decision status |
| RiskLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Low' | Risk level |
| ThreatIndicator | BOOLEAN | NOT NULL, DEFAULT FALSE | Threat indicator flag |
| SuspiciousActivity | BOOLEAN | NOT NULL, DEFAULT FALSE | Suspicious activity flag |
| AnomalyDetected | BOOLEAN | NOT NULL, DEFAULT FALSE | Anomaly detection flag |
| FraudIndicator | BOOLEAN | NOT NULL, DEFAULT FALSE | Fraud indicator flag |
| PolicyViolation | BOOLEAN | NOT NULL, DEFAULT FALSE | Policy violation flag |
| ViolatedPolicy | VARCHAR(255) | NULL | Violated policy name |
| ComplianceViolation | BOOLEAN | NOT NULL, DEFAULT FALSE | Compliance violation flag |
| ViolatedRegulation | VARCHAR(255) | NULL | Violated regulation |
| IncidentId | VARCHAR(100) | NULL | Related incident identifier |
| InvestigationId | VARCHAR(100) | NULL | Investigation identifier |
| EvidenceFlag | BOOLEAN | NOT NULL, DEFAULT FALSE | Evidence flag |
| ChainOfCustody | TEXT | NULL | Chain of custody information |
| DigitalSignature | VARCHAR(512) | NULL | Digital signature |
| HashValue | VARCHAR(128) | NULL | Record hash value |
| EncryptionApplied | BOOLEAN | NOT NULL, DEFAULT FALSE | Encryption flag |
| EncryptionAlgorithm | VARCHAR(50) | NULL | Encryption algorithm used |
| KeyId | VARCHAR(100) | NULL | Encryption key identifier |
| CompressionApplied | BOOLEAN | NOT NULL, DEFAULT FALSE | Compression flag |
| CompressionRatio | DECIMAL(5,2) | NULL, CHECK >= 0 | Compression ratio |
| OriginalSize | BIGINT | NULL, CHECK >= 0 | Original size before compression |
| CompressedSize | BIGINT | NULL, CHECK >= 0 | Size after compression |
| BackupLocation | VARCHAR(500) | NULL | Backup storage location |
| ArchiveLocation | VARCHAR(500) | NULL | Archive storage location |
| ArchiveDate | DATE | NULL | Archive date |
| PurgeEligible | BOOLEAN | NOT NULL, DEFAULT FALSE | Purge eligibility flag |
| PurgeDate | DATE | NULL | Scheduled purge date |
| ImmutableRecord | BOOLEAN | NOT NULL, DEFAULT TRUE | Immutable record flag |
| RecordLocked | BOOLEAN | NOT NULL, DEFAULT TRUE | Record lock flag |
| VerificationStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Verified' | Record verification status |
| IntegrityCheck | VARCHAR(128) | NULL | Integrity check value |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL, DEFAULT 'SYSTEM' | Record creator |

### Constraints

```sql
-- Primary Key
ALTER TABLE AuditLog ADD CONSTRAINT PK_AuditLog PRIMARY KEY (AuditLogId);

-- Unique Constraints
ALTER TABLE AuditLog ADD CONSTRAINT UK_AuditLog_EventId UNIQUE (EventId);

-- Foreign Keys
ALTER TABLE AuditLog ADD CONSTRAINT FK_AuditLog_User 
    FOREIGN KEY (UserId) REFERENCES UserProfile(UserId);
ALTER TABLE AuditLog ADD CONSTRAINT FK_AuditLog_Session 
    FOREIGN KEY (SessionId) REFERENCES UserSession(SessionId);
ALTER TABLE AuditLog ADD CONSTRAINT FK_AuditLog_ImpersonatedUser 
    FOREIGN KEY (ImpersonatedUserId) REFERENCES UserProfile(UserId);
ALTER TABLE AuditLog ADD CONSTRAINT FK_AuditLog_ParentEvent 
    FOREIGN KEY (ParentEventId) REFERENCES AuditLog(EventId);
ALTER TABLE AuditLog ADD CONSTRAINT FK_AuditLog_RootEvent 
    FOREIGN KEY (RootEventId) REFERENCES AuditLog(EventId);
ALTER TABLE AuditLog ADD CONSTRAINT FK_AuditLog_Workflow 
    FOREIGN KEY (WorkflowId) REFERENCES AssessmentWorkflow(WorkflowId);
ALTER TABLE AuditLog ADD CONSTRAINT FK_AuditLog_ApprovedBy 
    FOREIGN KEY (ApprovedBy) REFERENCES UserProfile(UserId);

-- Check Constraints
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_EventType 
    CHECK (EventType IN ('Create', 'Read', 'Update', 'Delete', 'Login', 'Logout', 'Search', 
                         'Export', 'Import', 'Approve', 'Reject', 'Submit', 'Cancel', 'Archive'));
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_EventCategory 
    CHECK (EventCategory IN ('Data', 'Security', 'System', 'Business', 'Integration', 'Compliance'));
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_EventSeverity 
    CHECK (EventSeverity IN ('Trace', 'Debug', 'Info', 'Warn', 'Error', 'Fatal', 'Critical'));
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_SecurityLevel 
    CHECK (SecurityLevel IN ('Low', 'Normal', 'Elevated', 'High', 'Critical'));
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_DataClassification 
    CHECK (DataClassification IN ('Public', 'Internal', 'Confidential', 'Restricted'));
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_RiskLevel 
    CHECK (RiskLevel IN ('Low', 'Medium', 'High', 'Critical'));
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_ApprovalStatus 
    CHECK (ApprovalStatus IN ('Pending', 'Approved', 'Rejected', 'Not Required') OR ApprovalStatus IS NULL);
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_ConsentStatus 
    CHECK (ConsentStatus IN ('Given', 'Withdrawn', 'Pending', 'Not Required') OR ConsentStatus IS NULL);
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_VerificationStatus 
    CHECK (VerificationStatus IN ('Verified', 'Pending', 'Failed', 'Not Required'));

-- Business Rules
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_ApprovalTimestamp 
    CHECK (ApprovalTimestamp IS NULL OR ApprovalTimestamp >= EventTimestamp);
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_ArchiveDate 
    CHECK (ArchiveDate IS NULL OR ArchiveDate >= CAST(EventTimestamp AS DATE));
ALTER TABLE AuditLog ADD CONSTRAINT CK_AuditLog_PurgeDate 
    CHECK (PurgeDate IS NULL OR PurgeDate > CAST(EventTimestamp AS DATE));
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_AuditLog_UserId ON AuditLog(UserId);
CREATE INDEX IX_AuditLog_SessionId ON AuditLog(SessionId);
CREATE INDEX IX_AuditLog_ImpersonatedUserId ON AuditLog(ImpersonatedUserId);
CREATE INDEX IX_AuditLog_ParentEventId ON AuditLog(ParentEventId);
CREATE INDEX IX_AuditLog_RootEventId ON AuditLog(RootEventId);
CREATE INDEX IX_AuditLog_WorkflowId ON AuditLog(WorkflowId);
CREATE INDEX IX_AuditLog_ApprovedBy ON AuditLog(ApprovedBy);

-- Critical Performance Indexes
CREATE INDEX IX_AuditLog_EventTimestamp ON AuditLog(EventTimestamp DESC);
CREATE INDEX IX_AuditLog_EventSequence ON AuditLog(EventSequence DESC);
CREATE INDEX IX_AuditLog_CreatedDate ON AuditLog(CreatedDate DESC);

-- Event Classification Indexes
CREATE INDEX IX_AuditLog_EventType ON AuditLog(EventType);
CREATE INDEX IX_AuditLog_EventCategory ON AuditLog(EventCategory);
CREATE INDEX IX_AuditLog_EventSeverity ON AuditLog(EventSeverity);
CREATE INDEX IX_AuditLog_EventSource ON AuditLog(EventSource);

-- Security and Compliance Indexes
CREATE INDEX IX_AuditLog_SecurityLevel ON AuditLog(SecurityLevel);
CREATE INDEX IX_AuditLog_DataClassification ON AuditLog(DataClassification);
CREATE INDEX IX_AuditLog_ComplianceRelevant ON AuditLog(ComplianceRelevant);
CREATE INDEX IX_AuditLog_RiskLevel ON AuditLog(RiskLevel);

-- Entity and Action Indexes
CREATE INDEX IX_AuditLog_EntityType ON AuditLog(EntityType);
CREATE INDEX IX_AuditLog_EntityId ON AuditLog(EntityId);
CREATE INDEX IX_AuditLog_ActionPerformed ON AuditLog(ActionPerformed);
CREATE INDEX IX_AuditLog_TableName ON AuditLog(TableName);

-- Anomaly and Fraud Detection Indexes
CREATE INDEX IX_AuditLog_SuspiciousActivity ON AuditLog(SuspiciousActivity);
CREATE INDEX IX_AuditLog_ThreatIndicator ON AuditLog(ThreatIndicator);
CREATE INDEX IX_AuditLog_AnomalyDetected ON AuditLog(AnomalyDetected);
CREATE INDEX IX_AuditLog_FraudIndicator ON AuditLog(FraudIndicator);

-- Violation and Incident Indexes
CREATE INDEX IX_AuditLog_PolicyViolation ON AuditLog(PolicyViolation);
CREATE INDEX IX_AuditLog_ComplianceViolation ON AuditLog(ComplianceViolation);
CREATE INDEX IX_AuditLog_IncidentId ON AuditLog(IncidentId);
CREATE INDEX IX_AuditLog_InvestigationId ON AuditLog(InvestigationId);

-- Data Management Indexes
CREATE INDEX IX_AuditLog_PersonalDataInvolved ON AuditLog(PersonalDataInvolved);
CREATE INDEX IX_AuditLog_SensitiveDataInvolved ON AuditLog(SensitiveDataInvolved);
CREATE INDEX IX_AuditLog_CrossBorderTransfer ON AuditLog(CrossBorderTransfer);
CREATE INDEX IX_AuditLog_LegalHoldFlag ON AuditLog(LegalHoldFlag);

-- Archive and Retention Indexes
CREATE INDEX IX_AuditLog_RetentionPeriod ON AuditLog(RetentionPeriod);
CREATE INDEX IX_AuditLog_ArchiveDate ON AuditLog(ArchiveDate);
CREATE INDEX IX_AuditLog_PurgeEligible ON AuditLog(PurgeEligible);
CREATE INDEX IX_AuditLog_PurgeDate ON AuditLog(PurgeDate);

-- Network and Location Indexes
CREATE INDEX IX_AuditLog_IPAddress ON AuditLog(IPAddress);
CREATE INDEX IX_AuditLog_LocationCountry ON AuditLog(LocationCountry);

-- Success and Error Indexes
CREATE INDEX IX_AuditLog_Success ON AuditLog(Success);
CREATE INDEX IX_AuditLog_ErrorCode ON AuditLog(ErrorCode);

-- Composite Indexes for Common Queries
CREATE INDEX IX_AuditLog_User_Timestamp ON AuditLog(UserId, EventTimestamp DESC);
CREATE INDEX IX_AuditLog_Type_Timestamp ON AuditLog(EventType, EventTimestamp DESC);
CREATE INDEX IX_AuditLog_Entity_Action_Timestamp ON AuditLog(EntityType, ActionPerformed, EventTimestamp DESC);
CREATE INDEX IX_AuditLog_Security_Timestamp ON AuditLog(SecurityLevel, EventTimestamp DESC);
CREATE INDEX IX_AuditLog_Compliance_Timestamp ON AuditLog(ComplianceRelevant, EventTimestamp DESC);

-- Partitioning by EventTimestamp (daily partitions recommended)
-- Implementation depends on database system
```

---

## Entity: DataChangeLog

### Purpose
Detailed tracking of data modifications with field-level change history for data lineage and compliance requirements.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| ChangeLogId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| AuditLogId | BIGINT | FK, NOT NULL | Reference to master audit log |
| ChangeId | VARCHAR(50) | UK, NOT NULL | Unique change identifier |
| ChangeTimestamp | TIMESTAMP | NOT NULL | Change occurrence timestamp |
| ChangeType | VARCHAR(10) | NOT NULL | INSERT, UPDATE, DELETE |
| ChangeReason | VARCHAR(255) | NULL | Reason for change |
| ChangeDescription | TEXT | NULL | Detailed change description |
| TableName | VARCHAR(128) | NOT NULL | Database table name |
| SchemaName | VARCHAR(128) | NOT NULL | Database schema name |
| DatabaseName | VARCHAR(128) | NOT NULL | Database name |
| PrimaryKeyValue | VARCHAR(500) | NOT NULL | Primary key value(s) |
| RecordIdentifier | TEXT | NOT NULL | Record identification (JSON) |
| RecordVersion | VARCHAR(20) | NULL | Record version |
| FieldName | VARCHAR(128) | NOT NULL | Changed field name |
| FieldType | VARCHAR(50) | NOT NULL | Field data type |
| FieldConstraints | VARCHAR(255) | NULL | Field constraints |
| OldValue | TEXT | NULL | Previous field value |
| NewValue | TEXT | NULL | New field value |
| OldValueHash | VARCHAR(128) | NULL | Hash of old value |
| NewValueHash | VARCHAR(128) | NULL | Hash of new value |
| ValueLength | INT | NULL, CHECK >= 0 | Value length |
| IsNullChange | BOOLEAN | NOT NULL, DEFAULT FALSE | NULL value change flag |
| IsDefaultValue | BOOLEAN | NOT NULL, DEFAULT FALSE | Default value flag |
| IsCalculatedField | BOOLEAN | NOT NULL, DEFAULT FALSE | Calculated field flag |
| IsSystemGenerated | BOOLEAN | NOT NULL, DEFAULT FALSE | System-generated value flag |
| IsSensitiveData | BOOLEAN | NOT NULL, DEFAULT FALSE | Sensitive data flag |
| IsPersonalData | BOOLEAN | NOT NULL, DEFAULT FALSE | Personal data flag |
| IsEncrypted | BOOLEAN | NOT NULL, DEFAULT FALSE | Encrypted field flag |
| EncryptionMethod | VARCHAR(50) | NULL | Encryption method used |
| DataClassification | VARCHAR(20) | NOT NULL, DEFAULT 'Internal' | Data classification level |
| BusinessImpact | VARCHAR(10) | NULL | Business impact level |
| ComplianceImpact | VARCHAR(10) | NULL | Compliance impact level |
| ValidationStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Valid' | Field validation status |
| ValidationErrors | TEXT | NULL | Validation error messages |
| DataQualityScore | DECIMAL(3,2) | NULL, CHECK BETWEEN 0 AND 1 | Data quality score |
| ConflictDetected | BOOLEAN | NOT NULL, DEFAULT FALSE | Data conflict flag |
| ConflictResolution | VARCHAR(100) | NULL | Conflict resolution method |
| ApprovalRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Change approval required |
| ApprovalStatus | VARCHAR(20) | NULL | Approval status |
| ApprovedBy | VARCHAR(50) | FK, NULL | Approving user |
| ApprovalTimestamp | TIMESTAMP | NULL | Approval timestamp |
| RollbackEligible | BOOLEAN | NOT NULL, DEFAULT TRUE | Rollback eligibility |
| RollbackComplexity | VARCHAR(10) | NULL | Rollback complexity level |
| RelatedChanges | TEXT | NULL | Related changes (JSON array) |
| DependentChanges | TEXT | NULL | Dependent changes (JSON array) |
| ChangeSequence | INT | NOT NULL, DEFAULT 1, CHECK > 0 | Change sequence in transaction |
| TransactionId | VARCHAR(100) | NULL | Transaction identifier |
| BatchId | VARCHAR(100) | NULL | Batch operation identifier |
| MigrationId | VARCHAR(100) | NULL | Data migration identifier |
| IntegrationSource | VARCHAR(100) | NULL | Integration source system |
| DataSourceSystem | VARCHAR(100) | NULL | Original data source |
| DataSourceId | VARCHAR(100) | NULL | Source record identifier |
| SyncStatus | VARCHAR(20) | NULL | Synchronization status |
| LastSyncTimestamp | TIMESTAMP | NULL | Last sync timestamp |
| ConflictResolutionTimestamp | TIMESTAMP | NULL | Conflict resolution timestamp |
| RetentionPeriod | INT | NOT NULL, DEFAULT 2555, CHECK > 0 | Retention period in days |
| ArchiveEligible | BOOLEAN | NOT NULL, DEFAULT TRUE | Archive eligibility |
| ArchiveDate | DATE | NULL | Archive date |
| PurgeEligible | BOOLEAN | NOT NULL, DEFAULT FALSE | Purge eligibility |
| PurgeDate | DATE | NULL | Scheduled purge date |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |

### Constraints

```sql
-- Primary Key
ALTER TABLE DataChangeLog ADD CONSTRAINT PK_DataChangeLog PRIMARY KEY (ChangeLogId);

-- Unique Constraints
ALTER TABLE DataChangeLog ADD CONSTRAINT UK_DataChangeLog_ChangeId UNIQUE (ChangeId);

-- Foreign Keys
ALTER TABLE DataChangeLog ADD CONSTRAINT FK_DataChangeLog_AuditLog 
    FOREIGN KEY (AuditLogId) REFERENCES AuditLog(AuditLogId);
ALTER TABLE DataChangeLog ADD CONSTRAINT FK_DataChangeLog_ApprovedBy 
    FOREIGN KEY (ApprovedBy) REFERENCES UserProfile(UserId);

-- Check Constraints
ALTER TABLE DataChangeLog ADD CONSTRAINT CK_DataChangeLog_ChangeType 
    CHECK (ChangeType IN ('INSERT', 'UPDATE', 'DELETE'));
ALTER TABLE DataChangeLog ADD CONSTRAINT CK_DataChangeLog_DataClassification 
    CHECK (DataClassification IN ('Public', 'Internal', 'Confidential', 'Restricted'));
ALTER TABLE DataChangeLog ADD CONSTRAINT CK_DataChangeLog_BusinessImpact 
    CHECK (BusinessImpact IN ('Low', 'Medium', 'High', 'Critical') OR BusinessImpact IS NULL);
ALTER TABLE DataChangeLog ADD CONSTRAINT CK_DataChangeLog_ComplianceImpact 
    CHECK (ComplianceImpact IN ('Low', 'Medium', 'High', 'Critical') OR ComplianceImpact IS NULL);
ALTER TABLE DataChangeLog ADD CONSTRAINT CK_DataChangeLog_ValidationStatus 
    CHECK (ValidationStatus IN ('Valid', 'Invalid', 'Warning', 'Pending', 'Not Validated'));
ALTER TABLE DataChangeLog ADD CONSTRAINT CK_DataChangeLog_ApprovalStatus 
    CHECK (ApprovalStatus IN ('Pending', 'Approved', 'Rejected', 'Not Required') OR ApprovalStatus IS NULL);
ALTER TABLE DataChangeLog ADD CONSTRAINT CK_DataChangeLog_RollbackComplexity 
    CHECK (RollbackComplexity IN ('Simple', 'Medium', 'Complex', 'Not Possible') OR RollbackComplexity IS NULL);
ALTER TABLE DataChangeLog ADD CONSTRAINT CK_DataChangeLog_SyncStatus 
    CHECK (SyncStatus IN ('Pending', 'In Progress', 'Completed', 'Failed', 'Not Required') OR SyncStatus IS NULL);

-- Business Rules
ALTER TABLE DataChangeLog ADD CONSTRAINT CK_DataChangeLog_ApprovalTimestamp 
    CHECK (ApprovalTimestamp IS NULL OR ApprovalTimestamp >= ChangeTimestamp);
ALTER TABLE DataChangeLog ADD CONSTRAINT CK_DataChangeLog_ValueChange 
    CHECK (ChangeType = 'DELETE' OR (OldValue IS NOT NULL OR NewValue IS NOT NULL));
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_DataChangeLog_AuditLogId ON DataChangeLog(AuditLogId);
CREATE INDEX IX_DataChangeLog_ApprovedBy ON DataChangeLog(ApprovedBy);

-- Change Tracking Indexes
CREATE INDEX IX_DataChangeLog_ChangeTimestamp ON DataChangeLog(ChangeTimestamp DESC);
CREATE INDEX IX_DataChangeLog_ChangeType ON DataChangeLog(ChangeType);
CREATE INDEX IX_DataChangeLog_TableName ON DataChangeLog(TableName);
CREATE INDEX IX_DataChangeLog_FieldName ON DataChangeLog(FieldName);

-- Record Identification Indexes
CREATE INDEX IX_DataChangeLog_PrimaryKeyValue ON DataChangeLog(PrimaryKeyValue);
CREATE INDEX IX_DataChangeLog_TransactionId ON DataChangeLog(TransactionId);
CREATE INDEX IX_DataChangeLog_BatchId ON DataChangeLog(BatchId);

-- Data Classification Indexes
CREATE INDEX IX_DataChangeLog_DataClassification ON DataChangeLog(DataClassification);
CREATE INDEX IX_DataChangeLog_IsSensitiveData ON DataChangeLog(IsSensitiveData);
CREATE INDEX IX_DataChangeLog_IsPersonalData ON DataChangeLog(IsPersonalData);

-- Approval and Validation Indexes
CREATE INDEX IX_DataChangeLog_ApprovalStatus ON DataChangeLog(ApprovalStatus);
CREATE INDEX IX_DataChangeLog_ValidationStatus ON DataChangeLog(ValidationStatus);
CREATE INDEX IX_DataChangeLog_ApprovalRequired ON DataChangeLog(ApprovalRequired);

-- System and Integration Indexes
CREATE INDEX IX_DataChangeLog_IntegrationSource ON DataChangeLog(IntegrationSource);
CREATE INDEX IX_DataChangeLog_MigrationId ON DataChangeLog(MigrationId);
CREATE INDEX IX_DataChangeLog_SyncStatus ON DataChangeLog(SyncStatus);

-- Archive and Retention Indexes
CREATE INDEX IX_DataChangeLog_ArchiveDate ON DataChangeLog(ArchiveDate);
CREATE INDEX IX_DataChangeLog_PurgeEligible ON DataChangeLog(PurgeEligible);

-- Composite Indexes
CREATE INDEX IX_DataChangeLog_Table_Field_Timestamp ON DataChangeLog(TableName, FieldName, ChangeTimestamp DESC);
CREATE INDEX IX_DataChangeLog_PK_Timestamp ON DataChangeLog(PrimaryKeyValue, ChangeTimestamp DESC);
CREATE INDEX IX_DataChangeLog_Type_Classification ON DataChangeLog(ChangeType, DataClassification);
```

---

## Entity: SystemEventLog

### Purpose
System-level events, performance metrics, and operational intelligence for system monitoring and optimization.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| EventLogId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| EventId | VARCHAR(50) | UK, NOT NULL | Unique event identifier |
| EventTimestamp | TIMESTAMP | NOT NULL | Event occurrence timestamp |
| EventType | VARCHAR(50) | NOT NULL | System Start, Error, Warning, etc. |
| EventCategory | VARCHAR(30) | NOT NULL | System, Performance, Integration, etc. |
| EventSeverity | VARCHAR(10) | NOT NULL, DEFAULT 'Info' | Event severity level |
| SystemComponent | VARCHAR(100) | NOT NULL | System component name |
| ComponentVersion | VARCHAR(20) | NULL | Component version |
| ProcessName | VARCHAR(255) | NULL | Process name |
| ProcessId | INT | NULL, CHECK > 0 | Process identifier |
| ThreadId | INT | NULL, CHECK > 0 | Thread identifier |
| ServiceName | VARCHAR(100) | NULL | Service name |
| ServiceStatus | VARCHAR(20) | NULL | Service status |
| ServerName | VARCHAR(100) | NOT NULL | Server name |
| ServerRole | VARCHAR(50) | NULL | Server role |
| Environment | VARCHAR(20) | NOT NULL | Environment (Prod, Test, Dev) |
| ApplicationName | VARCHAR(100) | NOT NULL | Application name |
| ApplicationVersion | VARCHAR(20) | NULL | Application version |
| ModuleName | VARCHAR(100) | NULL | Module or subsystem |
| FunctionName | VARCHAR(255) | NULL | Function or method |
| EventMessage | TEXT | NOT NULL | Event message |
| EventDescription | TEXT | NULL | Detailed description |
| ErrorCode | VARCHAR(50) | NULL | Error code |
| ErrorMessage | TEXT | NULL | Error message |
| ExceptionType | VARCHAR(255) | NULL | Exception type |
| ExceptionMessage | TEXT | NULL | Exception message |
| StackTrace | TEXT | NULL | Stack trace |
| InnerException | TEXT | NULL | Inner exception details |
| PerformanceMetrics | TEXT | NULL | Performance metrics (JSON) |
| ExecutionTimeMs | INT | NULL, CHECK >= 0 | Execution time in milliseconds |
| MemoryUsageMB | DECIMAL(10,2) | NULL, CHECK >= 0 | Memory usage in MB |
| CPUUsagePercent | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | CPU usage percentage |
| DiskUsagePercent | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Disk usage percentage |
| NetworkBytesIn | BIGINT | NULL, CHECK >= 0 | Network bytes received |
| NetworkBytesOut | BIGINT | NULL, CHECK >= 0 | Network bytes sent |
| DatabaseConnections | INT | NULL, CHECK >= 0 | Active database connections |
| ConnectionPoolSize | INT | NULL, CHECK >= 0 | Connection pool size |
| QueryCount | INT | NULL, CHECK >= 0 | Database queries executed |
| QueryExecutionTimeMs | INT | NULL, CHECK >= 0 | Database query time |
| CacheHitRatio | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Cache hit ratio |
| CacheSize | BIGINT | NULL, CHECK >= 0 | Cache size in bytes |
| QueueLength | INT | NULL, CHECK >= 0 | Queue length |
| ThreadPoolSize | INT | NULL, CHECK >= 0 | Thread pool size |
| ActiveSessions | INT | NULL, CHECK >= 0 | Active user sessions |
| ConcurrentUsers | INT | NULL, CHECK >= 0 | Concurrent users |
| RequestCount | INT | NULL, CHECK >= 0 | Request count |
| ResponseTimeMs | INT | NULL, CHECK >= 0 | Response time |
| ThroughputPerSecond | DECIMAL(10,2) | NULL, CHECK >= 0 | Throughput per second |
| SystemLoad | DECIMAL(5,2) | NULL, CHECK >= 0 | System load average |
| AvailableMemoryMB | DECIMAL(10,2) | NULL, CHECK >= 0 | Available memory |
| FreeDiskSpaceGB | DECIMAL(10,2) | NULL, CHECK >= 0 | Free disk space |
| NetworkLatencyMs | INT | NULL, CHECK >= 0 | Network latency |
| BandwidthUtilization | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Bandwidth utilization |
| ConfigurationChanges | TEXT | NULL | Configuration changes (JSON) |
| EnvironmentVariables | TEXT | NULL | Environment variables (JSON) |
| SystemSettings | TEXT | NULL | System settings (JSON) |
| SecurityContext | TEXT | NULL | Security context |
| UserContext | VARCHAR(50) | FK, NULL | User context |
| SessionContext | VARCHAR(128) | FK, NULL | Session context |
| TransactionContext | VARCHAR(100) | NULL | Transaction context |
| CorrelationId | VARCHAR(100) | NULL | Correlation identifier |
| TraceId | VARCHAR(100) | NULL | Distributed trace ID |
| SpanId | VARCHAR(100) | NULL | Trace span ID |
| ParentSpanId | VARCHAR(100) | NULL | Parent span ID |
| BusinessProcess | VARCHAR(100) | NULL | Business process context |
| IntegrationPoint | VARCHAR(100) | NULL | Integration point |
| ExternalSystem | VARCHAR(100) | NULL | External system name |
| ExternalSystemVersion | VARCHAR(20) | NULL | External system version |
| DataSyncStatus | VARCHAR(20) | NULL | Data synchronization status |
| ApiEndpoint | VARCHAR(500) | NULL | API endpoint |
| HttpMethod | VARCHAR(10) | NULL | HTTP method |
| HttpStatusCode | INT | NULL, CHECK >= 100 | HTTP status code |
| RequestSize | BIGINT | NULL, CHECK >= 0 | Request size in bytes |
| ResponseSize | BIGINT | NULL, CHECK >= 0 | Response size in bytes |
| UserAgent | VARCHAR(1000) | NULL | User agent string |
| IPAddress | VARCHAR(45) | NULL | Client IP address |
| LocationCountry | VARCHAR(100) | NULL | Geographic location |
| AlertTriggered | BOOLEAN | NOT NULL, DEFAULT FALSE | Alert triggered flag |
| AlertSeverity | VARCHAR(10) | NULL | Alert severity |
| AlertMessage | TEXT | NULL | Alert message |
| NotificationSent | BOOLEAN | NOT NULL, DEFAULT FALSE | Notification sent flag |
| NotificationRecipients | TEXT | NULL | Notification recipients |
| EscalationLevel | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Escalation level |
| IncidentCreated | BOOLEAN | NOT NULL, DEFAULT FALSE | Incident created flag |
| IncidentId | VARCHAR(100) | NULL | Incident identifier |
| ResolutionTime | INT | NULL, CHECK >= 0 | Resolution time in minutes |
| ResolutionAction | TEXT | NULL | Resolution action taken |
| RootCauseAnalysis | TEXT | NULL | Root cause analysis |
| PreventativeActions | TEXT | NULL | Preventative actions |
| RecoveryActions | TEXT | NULL | Recovery actions taken |
| BusinessImpact | VARCHAR(10) | NULL | Business impact level |
| ServiceLevelImpact | VARCHAR(10) | NULL | Service level impact |
| CustomerImpact | BOOLEAN | NOT NULL, DEFAULT FALSE | Customer impact flag |
| RevenueImpact | DECIMAL(19,4) | NULL, CHECK >= 0 | Revenue impact amount |
| ComplianceImpact | BOOLEAN | NOT NULL, DEFAULT FALSE | Compliance impact flag |
| SecurityImpact | BOOLEAN | NOT NULL, DEFAULT FALSE | Security impact flag |
| DataIntegrityImpact | BOOLEAN | NOT NULL, DEFAULT FALSE | Data integrity impact |
| AvailabilityImpact | BOOLEAN | NOT NULL, DEFAULT FALSE | Availability impact |
| PerformanceImpact | BOOLEAN | NOT NULL, DEFAULT FALSE | Performance impact |
| BackupStatus | VARCHAR(20) | NULL | Backup status |
| BackupLocation | VARCHAR(500) | NULL | Backup location |
| RecoveryPointObjective | INT | NULL, CHECK >= 0 | RPO in minutes |
| RecoveryTimeObjective | INT | NULL, CHECK >= 0 | RTO in minutes |
| MaintenanceWindow | VARCHAR(100) | NULL | Maintenance window |
| ScheduledDowntime | BOOLEAN | NOT NULL, DEFAULT FALSE | Scheduled downtime flag |
| RetentionPeriod | INT | NOT NULL, DEFAULT 90, CHECK > 0 | Retention period in days |
| ArchiveEligible | BOOLEAN | NOT NULL, DEFAULT TRUE | Archive eligibility |
| ArchiveDate | DATE | NULL | Archive date |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |

### Constraints

```sql
-- Primary Key
ALTER TABLE SystemEventLog ADD CONSTRAINT PK_SystemEventLog PRIMARY KEY (EventLogId);

-- Unique Constraints
ALTER TABLE SystemEventLog ADD CONSTRAINT UK_SystemEventLog_EventId UNIQUE (EventId);

-- Foreign Keys
ALTER TABLE SystemEventLog ADD CONSTRAINT FK_SystemEventLog_UserContext 
    FOREIGN KEY (UserContext) REFERENCES UserProfile(UserId);
ALTER TABLE SystemEventLog ADD CONSTRAINT FK_SystemEventLog_SessionContext 
    FOREIGN KEY (SessionContext) REFERENCES UserSession(SessionId);

-- Check Constraints
ALTER TABLE SystemEventLog ADD CONSTRAINT CK_SystemEventLog_EventType 
    CHECK (EventType IN ('System Start', 'System Stop', 'Service Start', 'Service Stop', 'Error', 
                        'Warning', 'Information', 'Configuration Change', 'Performance Alert', 
                        'Security Event', 'Backup', 'Recovery', 'Maintenance'));
ALTER TABLE SystemEventLog ADD CONSTRAINT CK_SystemEventLog_EventCategory 
    CHECK (EventCategory IN ('System', 'Performance', 'Security', 'Integration', 'Database', 
                            'Network', 'Storage', 'Application', 'Service', 'Infrastructure'));
ALTER TABLE SystemEventLog ADD CONSTRAINT CK_SystemEventLog_EventSeverity 
    CHECK (EventSeverity IN ('Trace', 'Debug', 'Info', 'Warn', 'Error', 'Fatal', 'Critical'));
ALTER TABLE SystemEventLog ADD CONSTRAINT CK_SystemEventLog_Environment 
    CHECK (Environment IN ('Production', 'Staging', 'Test', 'Development', 'Sandbox'));
ALTER TABLE SystemEventLog ADD CONSTRAINT CK_SystemEventLog_ServiceStatus 
    CHECK (ServiceStatus IN ('Running', 'Stopped', 'Starting', 'Stopping', 'Paused', 'Error') OR ServiceStatus IS NULL);
ALTER TABLE SystemEventLog ADD CONSTRAINT CK_SystemEventLog_AlertSeverity 
    CHECK (AlertSeverity IN ('Low', 'Medium', 'High', 'Critical') OR AlertSeverity IS NULL);
ALTER TABLE SystemEventLog ADD CONSTRAINT CK_SystemEventLog_BusinessImpact 
    CHECK (BusinessImpact IN ('None', 'Low', 'Medium', 'High', 'Critical') OR BusinessImpact IS NULL);
ALTER TABLE SystemEventLog ADD CONSTRAINT CK_SystemEventLog_ServiceLevelImpact 
    CHECK (ServiceLevelImpact IN ('None', 'Low', 'Medium', 'High', 'Critical') OR ServiceLevelImpact IS NULL);
ALTER TABLE SystemEventLog ADD CONSTRAINT CK_SystemEventLog_BackupStatus 
    CHECK (BackupStatus IN ('Success', 'Failed', 'In Progress', 'Partial', 'Cancelled') OR BackupStatus IS NULL);
ALTER TABLE SystemEventLog ADD CONSTRAINT CK_SystemEventLog_DataSyncStatus 
    CHECK (DataSyncStatus IN ('Success', 'Failed', 'In Progress', 'Partial', 'Cancelled') OR DataSyncStatus IS NULL);
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_SystemEventLog_UserContext ON SystemEventLog(UserContext);
CREATE INDEX IX_SystemEventLog_SessionContext ON SystemEventLog(SessionContext);

-- Critical Performance Indexes
CREATE INDEX IX_SystemEventLog_EventTimestamp ON SystemEventLog(EventTimestamp DESC);
CREATE INDEX IX_SystemEventLog_CreatedDate ON SystemEventLog(CreatedDate DESC);

-- Event Classification Indexes
CREATE INDEX IX_SystemEventLog_EventType ON SystemEventLog(EventType);
CREATE INDEX IX_SystemEventLog_EventCategory ON SystemEventLog(EventCategory);
CREATE INDEX IX_SystemEventLog_EventSeverity ON SystemEventLog(EventSeverity);

-- System Component Indexes
CREATE INDEX IX_SystemEventLog_SystemComponent ON SystemEventLog(SystemComponent);
CREATE INDEX IX_SystemEventLog_ServerName ON SystemEventLog(ServerName);
CREATE INDEX IX_SystemEventLog_ApplicationName ON SystemEventLog(ApplicationName);
CREATE INDEX IX_SystemEventLog_Environment ON SystemEventLog(Environment);

-- Performance Monitoring Indexes
CREATE INDEX IX_SystemEventLog_ExecutionTimeMs ON SystemEventLog(ExecutionTimeMs DESC);
CREATE INDEX IX_SystemEventLog_CPUUsagePercent ON SystemEventLog(CPUUsagePercent DESC);
CREATE INDEX IX_SystemEventLog_MemoryUsageMB ON SystemEventLog(MemoryUsageMB DESC);

-- Alert and Incident Indexes
CREATE INDEX IX_SystemEventLog_AlertTriggered ON SystemEventLog(AlertTriggered);
CREATE INDEX IX_SystemEventLog_AlertSeverity ON SystemEventLog(AlertSeverity);
CREATE INDEX IX_SystemEventLog_IncidentCreated ON SystemEventLog(IncidentCreated);
CREATE INDEX IX_SystemEventLog_IncidentId ON SystemEventLog(IncidentId);

-- Error and Exception Indexes
CREATE INDEX IX_SystemEventLog_ErrorCode ON SystemEventLog(ErrorCode);
CREATE INDEX IX_SystemEventLog_ExceptionType ON SystemEventLog(ExceptionType);

-- Business Impact Indexes
CREATE INDEX IX_SystemEventLog_BusinessImpact ON SystemEventLog(BusinessImpact);
CREATE INDEX IX_SystemEventLog_CustomerImpact ON SystemEventLog(CustomerImpact);
CREATE INDEX IX_SystemEventLog_ComplianceImpact ON SystemEventLog(ComplianceImpact);
CREATE INDEX IX_SystemEventLog_SecurityImpact ON SystemEventLog(SecurityImpact);

-- Integration and External System Indexes
CREATE INDEX IX_SystemEventLog_IntegrationPoint ON SystemEventLog(IntegrationPoint);
CREATE INDEX IX_SystemEventLog_ExternalSystem ON SystemEventLog(ExternalSystem);
CREATE INDEX IX_SystemEventLog_DataSyncStatus ON SystemEventLog(DataSyncStatus);

-- Network and Performance Indexes
CREATE INDEX IX_SystemEventLog_IPAddress ON SystemEventLog(IPAddress);
CREATE INDEX IX_SystemEventLog_ResponseTimeMs ON SystemEventLog(ResponseTimeMs DESC);
CREATE INDEX IX_SystemEventLog_HttpStatusCode ON SystemEventLog(HttpStatusCode);

-- Composite Indexes for Common Queries
CREATE INDEX IX_SystemEventLog_Component_Severity_Timestamp ON SystemEventLog(SystemComponent, EventSeverity, EventTimestamp DESC);
CREATE INDEX IX_SystemEventLog_App_Type_Timestamp ON SystemEventLog(ApplicationName, EventType, EventTimestamp DESC);
CREATE INDEX IX_SystemEventLog_Server_Category_Timestamp ON SystemEventLog(ServerName, EventCategory, EventTimestamp DESC);
CREATE INDEX IX_SystemEventLog_Error_Timestamp ON SystemEventLog(EventSeverity, EventTimestamp DESC) WHERE EventSeverity IN ('Error', 'Fatal', 'Critical');

-- Partitioning by EventTimestamp (daily partitions recommended)
-- Implementation depends on database system
```

---

## Business Rules and Calculations

### Audit Retention Management

```sql
-- Function to calculate audit retention requirements
CREATE FUNCTION CalculateAuditRetention(
    @EventType VARCHAR(50),
    @DataClassification VARCHAR(20),
    @ComplianceRelevant BOOLEAN,
    @LegalHoldFlag BOOLEAN
)
RETURNS INT
AS
BEGIN
    DECLARE @RetentionDays INT = 365; -- Default 1 year
    
    -- Legal hold overrides all other rules
    IF @LegalHoldFlag = 1
        RETURN 9999; -- Indefinite retention
    
    -- Compliance-relevant events
    IF @ComplianceRelevant = 1
    BEGIN
        SET @RetentionDays = 2555; -- 7 years
    END
    
    -- High-value data requires longer retention
    IF @DataClassification IN ('Confidential', 'Restricted')
    BEGIN
        SET @RetentionDays = CASE 
            WHEN @RetentionDays > 1825 THEN @RetentionDays 
            ELSE 1825 -- 5 years minimum
        END;
    END
    
    -- Security events require extended retention
    IF @EventType IN ('Login', 'Logout', 'Security Event', 'Policy Violation')
    BEGIN
        SET @RetentionDays = CASE 
            WHEN @RetentionDays > 1095 THEN @RetentionDays 
            ELSE 1095 -- 3 years minimum
        END;
    END
    
    RETURN @RetentionDays;
END;
```

### Suspicious Activity Detection

```sql
-- Stored procedure to detect suspicious patterns in audit logs
CREATE PROCEDURE DetectSuspiciousActivity(@LookbackHours INT = 24)
AS
BEGIN
    WITH SuspiciousPatterns AS (
        -- Multiple failed login attempts
        SELECT 
            UserId,
            'Multiple Failed Logins' AS Pattern,
            COUNT(*) AS Occurrences,
            MIN(EventTimestamp) AS FirstOccurrence,
            MAX(EventTimestamp) AS LastOccurrence,
            COUNT(DISTINCT IPAddress) AS UniqueIPs
        FROM AuditLog
        WHERE EventTimestamp >= DATEADD(hour, -@LookbackHours, GETDATE())
          AND EventType = 'Login'
          AND Success = 0
        GROUP BY UserId
        HAVING COUNT(*) >= 5
        
        UNION ALL
        
        -- Unusual access patterns
        SELECT 
            UserId,
            'Unusual Access Pattern' AS Pattern,
            COUNT(*) AS Occurrences,
            MIN(EventTimestamp) AS FirstOccurrence,
            MAX(EventTimestamp) AS LastOccurrence,
            COUNT(DISTINCT IPAddress) AS UniqueIPs
        FROM AuditLog
        WHERE EventTimestamp >= DATEADD(hour, -@LookbackHours, GETDATE())
          AND EventTimestamp BETWEEN '22:00:00' AND '06:00:00' -- After hours
          AND UserId IS NOT NULL
        GROUP BY UserId
        HAVING COUNT(*) >= 10
        
        UNION ALL
        
        -- High-volume data access
        SELECT 
            UserId,
            'High Volume Data Access' AS Pattern,
            COUNT(*) AS Occurrences,
            MIN(EventTimestamp) AS FirstOccurrence,
            MAX(EventTimestamp) AS LastOccurrence,
            COUNT(DISTINCT IPAddress) AS UniqueIPs
        FROM AuditLog
        WHERE EventTimestamp >= DATEADD(hour, -@LookbackHours, GETDATE())
          AND ActionPerformed IN ('Export', 'Download')
          AND SensitiveDataInvolved = 1
        GROUP BY UserId
        HAVING COUNT(*) >= 20
    )
    SELECT 
        sp.*,
        up.FirstName + ' ' + up.LastName AS UserName,
        up.Department,
        up.UserStatus,
        up.LastLoginDate
    FROM SuspiciousPatterns sp
    JOIN UserProfile up ON sp.UserId = up.UserId
    ORDER BY sp.LastOccurrence DESC, sp.Occurrences DESC;
    
    -- Update suspicious activity flags
    UPDATE AuditLog
    SET SuspiciousActivity = 1,
        ThreatIndicator = CASE WHEN al.UserId IN (
            SELECT UserId FROM SuspiciousPatterns
        ) THEN 1 ELSE ThreatIndicator END
    FROM AuditLog al
    WHERE EXISTS (
        SELECT 1 FROM SuspiciousPatterns sp 
        WHERE sp.UserId = al.UserId
        AND al.EventTimestamp BETWEEN sp.FirstOccurrence AND sp.LastOccurrence
    );
END;
```

### Data Lineage Tracking

```sql
-- View for comprehensive data lineage
CREATE VIEW DataLineageView AS
SELECT 
    dcl.TableName,
    dcl.PrimaryKeyValue,
    dcl.FieldName,
    dcl.ChangeTimestamp,
    dcl.ChangeType,
    dcl.OldValue,
    dcl.NewValue,
    al.UserId,
    up.FirstName + ' ' + up.LastName AS ChangedBy,
    al.BusinessProcess,
    al.BusinessJustification,
    dcl.IntegrationSource,
    dcl.DataSourceSystem,
    ROW_NUMBER() OVER (
        PARTITION BY dcl.TableName, dcl.PrimaryKeyValue, dcl.FieldName 
        ORDER BY dcl.ChangeTimestamp DESC
    ) AS ChangeSequence
FROM DataChangeLog dcl
JOIN AuditLog al ON dcl.AuditLogId = al.AuditLogId
LEFT JOIN UserProfile up ON al.UserId = up.UserId
WHERE dcl.ValidationStatus = 'Valid';
```

---

## Data Quality Rules

### Audit Log Integrity
- All audit entries must be immutable once created
- Critical security events must be duplicated to secure storage
- Hash values must be calculated for tamper detection
- Digital signatures required for legal evidence

### Data Change Tracking
- Every database modification must generate change log entry
- Field-level changes must be captured with before/after values
- Change approval workflows must be enforced for sensitive data
- Data lineage must be maintained across all transformations

### System Event Monitoring
- Performance thresholds must trigger automated alerts
- System resource utilization must be continuously monitored
- Integration points must log all communication attempts
- Error patterns must be analyzed for predictive maintenance

---

*Document Version*: 1.0  
*Last Updated*: August 21, 2025  
*Next Review*: September 21, 2025  
*Document Owner*: Audit & Compliance Team
