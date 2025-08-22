# Integration Entities - Logical Data Model

## Overview
This document defines the logical structure for external system integrations, data synchronization, API management, and inter-system communication for the Dynamic Supplier Diversification & Risk Scoring System.

---

## Entity: ExternalDataSource

### Purpose
Registry of external data sources, systems, and services that provide data to the supplier risk management system.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| DataSourceId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| SourceCode | VARCHAR(50) | UK, NOT NULL | External source identifier code |
| SourceName | VARCHAR(255) | NOT NULL | External source display name |
| SourceType | VARCHAR(30) | NOT NULL | Database, API, File, Service, etc. |
| SourceCategory | VARCHAR(30) | NOT NULL | Risk Data, Financial, Geographic, etc. |
| ProviderName | VARCHAR(255) | NOT NULL | Data provider organization |
| ProviderType | VARCHAR(30) | NOT NULL | Commercial, Government, Open Source |
| ContactInformation | TEXT | NULL | Provider contact details (JSON) |
| ServiceLevel | VARCHAR(20) | NOT NULL | Basic, Standard, Premium, Enterprise |
| DataClassification | VARCHAR(20) | NOT NULL, DEFAULT 'External' | Data classification level |
| TrustLevel | VARCHAR(10) | NOT NULL | Data source trust level |
| ReliabilityRating | VARCHAR(10) | NOT NULL | Data reliability rating |
| AccuracyRating | VARCHAR(10) | NOT NULL | Data accuracy rating |
| CompletenessRating | VARCHAR(10) | NULL | Data completeness rating |
| FreshnessRating | VARCHAR(10) | NULL | Data freshness rating |
| DataQualityScore | DECIMAL(3,2) | NULL, CHECK BETWEEN 0 AND 1 | Overall data quality score |
| GeographicCoverage | TEXT | NULL | Geographic coverage (JSON) |
| IndustryCoverage | TEXT | NULL | Industry coverage (JSON) |
| DataTypes | TEXT | NOT NULL | Data types provided (JSON) |
| DataVolume | VARCHAR(20) | NULL | Data volume classification |
| UpdateFrequency | VARCHAR(20) | NOT NULL | Data update frequency |
| HistoricalDepth | VARCHAR(20) | NULL | Historical data depth |
| RealTimeCapability | BOOLEAN | NOT NULL, DEFAULT FALSE | Real-time data flag |
| BatchCapability | BOOLEAN | NOT NULL, DEFAULT TRUE | Batch processing capability |
| StreamingCapability | BOOLEAN | NOT NULL, DEFAULT FALSE | Streaming data capability |
| APIAvailable | BOOLEAN | NOT NULL, DEFAULT FALSE | API access available |
| BulkDownloadAvailable | BOOLEAN | NOT NULL, DEFAULT FALSE | Bulk download available |
| WebScrapingAllowed | BOOLEAN | NOT NULL, DEFAULT FALSE | Web scraping allowed |
| DataFormats | TEXT | NULL | Supported data formats (JSON) |
| CompressionSupport | TEXT | NULL | Supported compression formats |
| EncryptionSupport | TEXT | NULL | Supported encryption methods |
| AuthenticationMethods | TEXT | NULL | Authentication methods (JSON) |
| AuthorizationModel | VARCHAR(50) | NULL | Authorization model |
| AccessCredentials | TEXT | NULL | Encrypted access credentials |
| RateLimits | TEXT | NULL | API rate limits (JSON) |
| DataRetentionPolicy | TEXT | NULL | Data retention policy |
| UsageLimitations | TEXT | NULL | Usage limitations |
| LicenseTerms | TEXT | NULL | License terms and conditions |
| ComplianceRequirements | TEXT | NULL | Compliance requirements (JSON) |
| DataProcessingAgreement | TEXT | NULL | Data processing agreement |
| PrivacyPolicy | TEXT | NULL | Privacy policy details |
| CostStructure | TEXT | NULL | Cost structure (JSON) |
| ContractDetails | TEXT | NULL | Contract details (JSON) |
| ContractStartDate | DATE | NULL | Contract start date |
| ContractEndDate | DATE | NULL | Contract end date |
| ContractRenewalDate | DATE | NULL | Contract renewal date |
| AutoRenewal | BOOLEAN | NOT NULL, DEFAULT FALSE | Auto-renewal flag |
| NoticePeriod | INT | NULL, CHECK >= 0 | Termination notice period (days) |
| ServiceLevelAgreement | TEXT | NULL | SLA terms (JSON) |
| UptimeRequirement | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Uptime percentage requirement |
| ResponseTimeRequirement | INT | NULL, CHECK >= 0 | Response time requirement (ms) |
| SupportLevel | VARCHAR(20) | NULL | Support level provided |
| SupportHours | VARCHAR(100) | NULL | Support hours |
| EscalationProcess | TEXT | NULL | Issue escalation process |
| DocumentationURL | VARCHAR(500) | NULL | Documentation URL |
| APIDocumentationURL | VARCHAR(500) | NULL | API documentation URL |
| TestEnvironmentURL | VARCHAR(500) | NULL | Test environment URL |
| ProductionEnvironmentURL | VARCHAR(500) | NULL | Production environment URL |
| MonitoringDashboardURL | VARCHAR(500) | NULL | Monitoring dashboard URL |
| StatusPageURL | VARCHAR(500) | NULL | Status page URL |
| ChangelogURL | VARCHAR(500) | NULL | Changelog URL |
| DeveloperPortalURL | VARCHAR(500) | NULL | Developer portal URL |
| CommunityForumURL | VARCHAR(500) | NULL | Community forum URL |
| TechnicalSpecifications | TEXT | NULL | Technical specifications |
| IntegrationComplexity | VARCHAR(10) | NOT NULL | Integration complexity level |
| MaintenanceRequirements | TEXT | NULL | Maintenance requirements |
| DependencyMapping | TEXT | NULL | System dependencies (JSON) |
| FailoverCapability | BOOLEAN | NOT NULL, DEFAULT FALSE | Failover capability |
| BackupSources | TEXT | NULL | Backup data sources (JSON) |
| DisasterRecovery | TEXT | NULL | Disaster recovery plan |
| SecurityRequirements | TEXT | NULL | Security requirements |
| CertificationStandards | TEXT | NULL | Certification standards (JSON) |
| AuditRequirements | TEXT | NULL | Audit requirements |
| ComplianceFrameworks | TEXT | NULL | Applicable compliance frameworks |
| RiskAssessment | TEXT | NULL | Risk assessment (JSON) |
| BusinessCriticality | VARCHAR(10) | NOT NULL | Business criticality level |
| BusinessImpact | VARCHAR(10) | NULL | Business impact of outage |
| AlternativeSources | TEXT | NULL | Alternative data sources (JSON) |
| MigrationPlan | TEXT | NULL | Migration plan if needed |
| ValidationRules | TEXT | NULL | Data validation rules (JSON) |
| TransformationRules | TEXT | NULL | Data transformation rules (JSON) |
| MappingRules | TEXT | NULL | Data mapping rules (JSON) |
| ConflictResolutionRules | TEXT | NULL | Data conflict resolution |
| DataLineageTracking | BOOLEAN | NOT NULL, DEFAULT TRUE | Data lineage tracking |
| ChangeDetection | BOOLEAN | NOT NULL, DEFAULT TRUE | Change detection enabled |
| DeltaProcessing | BOOLEAN | NOT NULL, DEFAULT FALSE | Delta processing capability |
| ErrorHandling | TEXT | NULL | Error handling procedures |
| RetryPolicy | TEXT | NULL | Retry policy configuration |
| TimeoutSettings | TEXT | NULL | Timeout settings (JSON) |
| LoggingLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Info' | Logging level |
| MonitoringEnabled | BOOLEAN | NOT NULL, DEFAULT TRUE | Monitoring enabled flag |
| AlertingEnabled | BOOLEAN | NOT NULL, DEFAULT TRUE | Alerting enabled flag |
| AlertThresholds | TEXT | NULL | Alert thresholds (JSON) |
| NotificationSettings | TEXT | NULL | Notification settings (JSON) |
| PerformanceMetrics | TEXT | NULL | Performance metrics (JSON) |
| QualityMetrics | TEXT | NULL | Quality metrics (JSON) |
| UsageStatistics | TEXT | NULL | Usage statistics (JSON) |
| LastSuccessfulSync | TIMESTAMP | NULL | Last successful synchronization |
| LastSyncAttempt | TIMESTAMP | NULL | Last synchronization attempt |
| SyncStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Not Configured' | Synchronization status |
| ErrorCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Error count |
| WarningCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Warning count |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active source flag |
| IsConfigured | BOOLEAN | NOT NULL, DEFAULT FALSE | Configuration complete flag |
| IsTestMode | BOOLEAN | NOT NULL, DEFAULT FALSE | Test mode flag |
| IsProduction | BOOLEAN | NOT NULL, DEFAULT FALSE | Production ready flag |
| RequiresApproval | BOOLEAN | NOT NULL, DEFAULT TRUE | Approval required flag |
| ApprovalStatus | VARCHAR(20) | NULL | Approval status |
| ApprovedBy | VARCHAR(50) | FK, NULL | Approving user |
| ApprovalDate | TIMESTAMP | NULL | Approval timestamp |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |
| LastHealthCheck | TIMESTAMP | NULL | Last health check timestamp |
| NextHealthCheck | TIMESTAMP | NULL | Next scheduled health check |

### Constraints

```sql
-- Primary Key
ALTER TABLE ExternalDataSource ADD CONSTRAINT PK_ExternalDataSource PRIMARY KEY (DataSourceId);

-- Unique Constraints
ALTER TABLE ExternalDataSource ADD CONSTRAINT UK_ExternalDataSource_SourceCode UNIQUE (SourceCode);

-- Foreign Keys
ALTER TABLE ExternalDataSource ADD CONSTRAINT FK_ExternalDataSource_ApprovedBy 
    FOREIGN KEY (ApprovedBy) REFERENCES UserProfile(UserId);

-- Check Constraints
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_SourceType 
    CHECK (SourceType IN ('Database', 'REST API', 'SOAP API', 'GraphQL', 'File Transfer', 'Message Queue', 
                         'Web Service', 'Cloud Storage', 'Data Lake', 'Stream Processing', 'Web Scraping'));
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_SourceCategory 
    CHECK (SourceCategory IN ('Risk Data', 'Financial Data', 'Geographic Data', 'Regulatory Data', 
                              'Market Data', 'Economic Data', 'ESG Data', 'Supplier Data', 'Product Data',
                              'Trade Data', 'Compliance Data', 'News Data', 'Social Media', 'Reference Data'));
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_ProviderType 
    CHECK (ProviderType IN ('Commercial', 'Government', 'NGO', 'Open Source', 'Academic', 'Internal', 'Partner'));
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_ServiceLevel 
    CHECK (ServiceLevel IN ('Basic', 'Standard', 'Premium', 'Enterprise', 'Custom'));
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_DataClassification 
    CHECK (DataClassification IN ('Public', 'Internal', 'Confidential', 'Restricted', 'External'));

-- Rating constraints
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_Ratings 
    CHECK (
        (TrustLevel IN ('Very Low', 'Low', 'Medium', 'High', 'Very High'))
        AND (ReliabilityRating IN ('Very Low', 'Low', 'Medium', 'High', 'Very High'))
        AND (AccuracyRating IN ('Very Low', 'Low', 'Medium', 'High', 'Very High'))
        AND (CompletenessRating IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR CompletenessRating IS NULL)
        AND (FreshnessRating IN ('Very Low', 'Low', 'Medium', 'High', 'Very High') OR FreshnessRating IS NULL)
    );

ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_UpdateFrequency 
    CHECK (UpdateFrequency IN ('Real-time', 'Hourly', 'Daily', 'Weekly', 'Monthly', 'Quarterly', 
                               'Annually', 'On-demand', 'Event-driven'));
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_IntegrationComplexity 
    CHECK (IntegrationComplexity IN ('Very Low', 'Low', 'Medium', 'High', 'Very High'));
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_BusinessCriticality 
    CHECK (BusinessCriticality IN ('Critical', 'High', 'Medium', 'Low', 'Optional'));
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_SyncStatus 
    CHECK (SyncStatus IN ('Not Configured', 'Configured', 'Active', 'Paused', 'Failed', 'Maintenance'));
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_ApprovalStatus 
    CHECK (ApprovalStatus IN ('Pending', 'Approved', 'Rejected', 'Under Review') OR ApprovalStatus IS NULL);
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_LoggingLevel 
    CHECK (LoggingLevel IN ('Trace', 'Debug', 'Info', 'Warn', 'Error', 'Fatal'));

-- Business Rules
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_ContractDates 
    CHECK (ContractEndDate IS NULL OR ContractStartDate IS NULL OR ContractEndDate > ContractStartDate);
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_ProductionFlag 
    CHECK (NOT (IsProduction = 1 AND IsTestMode = 1));
ALTER TABLE ExternalDataSource ADD CONSTRAINT CK_ExternalDataSource_ApprovalDate 
    CHECK (ApprovalDate IS NULL OR ApprovalDate <= GETDATE());
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_ExternalDataSource_ApprovedBy ON ExternalDataSource(ApprovedBy);

-- Classification Indexes
CREATE INDEX IX_ExternalDataSource_SourceType ON ExternalDataSource(SourceType);
CREATE INDEX IX_ExternalDataSource_SourceCategory ON ExternalDataSource(SourceCategory);
CREATE INDEX IX_ExternalDataSource_ProviderType ON ExternalDataSource(ProviderType);
CREATE INDEX IX_ExternalDataSource_DataClassification ON ExternalDataSource(DataClassification);

-- Search Indexes
CREATE INDEX IX_ExternalDataSource_SourceName ON ExternalDataSource(SourceName);
CREATE INDEX IX_ExternalDataSource_ProviderName ON ExternalDataSource(ProviderName);

-- Status and Configuration Indexes
CREATE INDEX IX_ExternalDataSource_IsActive ON ExternalDataSource(IsActive);
CREATE INDEX IX_ExternalDataSource_IsConfigured ON ExternalDataSource(IsConfigured);
CREATE INDEX IX_ExternalDataSource_IsProduction ON ExternalDataSource(IsProduction);
CREATE INDEX IX_ExternalDataSource_SyncStatus ON ExternalDataSource(SyncStatus);

-- Quality and Trust Indexes
CREATE INDEX IX_ExternalDataSource_TrustLevel ON ExternalDataSource(TrustLevel);
CREATE INDEX IX_ExternalDataSource_ReliabilityRating ON ExternalDataSource(ReliabilityRating);
CREATE INDEX IX_ExternalDataSource_DataQualityScore ON ExternalDataSource(DataQualityScore DESC);

-- Business Criticality Indexes
CREATE INDEX IX_ExternalDataSource_BusinessCriticality ON ExternalDataSource(BusinessCriticality);
CREATE INDEX IX_ExternalDataSource_IntegrationComplexity ON ExternalDataSource(IntegrationComplexity);

-- Capability Indexes
CREATE INDEX IX_ExternalDataSource_APIAvailable ON ExternalDataSource(APIAvailable);
CREATE INDEX IX_ExternalDataSource_RealTimeCapability ON ExternalDataSource(RealTimeCapability);
CREATE INDEX IX_ExternalDataSource_StreamingCapability ON ExternalDataSource(StreamingCapability);

-- Date-based Indexes
CREATE INDEX IX_ExternalDataSource_LastSuccessfulSync ON ExternalDataSource(LastSuccessfulSync DESC);
CREATE INDEX IX_ExternalDataSource_ContractEndDate ON ExternalDataSource(ContractEndDate);
CREATE INDEX IX_ExternalDataSource_NextHealthCheck ON ExternalDataSource(NextHealthCheck);

-- Composite Indexes for Common Queries
CREATE INDEX IX_ExternalDataSource_Active_Category ON ExternalDataSource(IsActive, SourceCategory);
CREATE INDEX IX_ExternalDataSource_Production_Status ON ExternalDataSource(IsProduction, SyncStatus);
CREATE INDEX IX_ExternalDataSource_Category_Trust ON ExternalDataSource(SourceCategory, TrustLevel);
```

---

## Entity: APIConnection

### Purpose
Configuration and management of API connections to external systems with endpoint definitions, authentication, and monitoring.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| ConnectionId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| DataSourceId | BIGINT | FK, NOT NULL | Reference to external data source |
| ConnectionName | VARCHAR(255) | NOT NULL | Connection display name |
| ConnectionType | VARCHAR(20) | NOT NULL | REST, SOAP, GraphQL, etc. |
| APIVersion | VARCHAR(20) | NULL | API version |
| BaseURL | VARCHAR(1000) | NOT NULL | Base API URL |
| EndpointPath | VARCHAR(500) | NOT NULL | Specific endpoint path |
| FullURL | VARCHAR(1500) | NOT NULL | Complete endpoint URL |
| HTTPMethod | VARCHAR(10) | NOT NULL | HTTP method |
| ContentType | VARCHAR(100) | NOT NULL, DEFAULT 'application/json' | Request content type |
| AcceptType | VARCHAR(100) | NOT NULL, DEFAULT 'application/json' | Response accept type |
| AuthenticationType | VARCHAR(30) | NOT NULL | Authentication method |
| AuthenticationEndpoint | VARCHAR(500) | NULL | Authentication endpoint |
| TokenType | VARCHAR(20) | NULL | Token type (Bearer, Basic, etc.) |
| TokenExpirationMinutes | INT | NULL, CHECK >= 0 | Token expiration period |
| RefreshTokenSupport | BOOLEAN | NOT NULL, DEFAULT FALSE | Refresh token support |
| APIKey | VARCHAR(500) | NULL | Encrypted API key |
| ClientId | VARCHAR(255) | NULL | OAuth client ID |
| ClientSecret | VARCHAR(500) | NULL | Encrypted client secret |
| Username | VARCHAR(255) | NULL | Basic auth username |
| Password | VARCHAR(500) | NULL | Encrypted password |
| Certificate | TEXT | NULL | Client certificate |
| CertificatePassword | VARCHAR(500) | NULL | Certificate password |
| CustomHeaders | TEXT | NULL | Custom headers (JSON) |
| QueryParameters | TEXT | NULL | Default query parameters (JSON) |
| RequestTemplate | TEXT | NULL | Request template |
| ResponseMapping | TEXT | NULL | Response field mapping (JSON) |
| ErrorMapping | TEXT | NULL | Error code mapping (JSON) |
| ValidationSchema | TEXT | NULL | Response validation schema |
| TransformationRules | TEXT | NULL | Data transformation rules |
| FilterCriteria | TEXT | NULL | Data filter criteria |
| PaginationSupport | BOOLEAN | NOT NULL, DEFAULT FALSE | Pagination support |
| PaginationType | VARCHAR(20) | NULL | Pagination method |
| PageSizeParameter | VARCHAR(50) | NULL | Page size parameter name |
| PageNumberParameter | VARCHAR(50) | NULL | Page number parameter name |
| MaxPageSize | INT | NULL, CHECK > 0 | Maximum page size |
| DefaultPageSize | INT | NULL, CHECK > 0 | Default page size |
| SortingSupport | BOOLEAN | NOT NULL, DEFAULT FALSE | Sorting support |
| SortParameter | VARCHAR(50) | NULL | Sort parameter name |
| DefaultSortOrder | VARCHAR(100) | NULL | Default sort order |
| FilteringSupport | BOOLEAN | NOT NULL, DEFAULT FALSE | Filtering support |
| FilterParameters | TEXT | NULL | Filter parameters (JSON) |
| DateRangeFiltering | BOOLEAN | NOT NULL, DEFAULT FALSE | Date range filtering |
| DateFromParameter | VARCHAR(50) | NULL | Date from parameter |
| DateToParameter | VARCHAR(50) | NULL | Date to parameter |
| IncrementalSupport | BOOLEAN | NOT NULL, DEFAULT FALSE | Incremental sync support |
| LastModifiedParameter | VARCHAR(50) | NULL | Last modified parameter |
| ChangeTokenSupport | BOOLEAN | NOT NULL, DEFAULT FALSE | Change token support |
| ChangeTokenParameter | VARCHAR(50) | NULL | Change token parameter |
| RateLimitRequests | INT | NULL, CHECK >= 0 | Rate limit requests |
| RateLimitPeriod | VARCHAR(20) | NULL | Rate limit period |
| RateLimitHeader | VARCHAR(100) | NULL | Rate limit header name |
| ThrottlingEnabled | BOOLEAN | NOT NULL, DEFAULT FALSE | Throttling enabled |
| ThrottlingDelay | INT | NULL, CHECK >= 0 | Throttling delay (ms) |
| RetryEnabled | BOOLEAN | NOT NULL, DEFAULT TRUE | Retry enabled |
| MaxRetryAttempts | INT | NOT NULL, DEFAULT 3, CHECK >= 0 | Maximum retry attempts |
| RetryDelay | INT | NOT NULL, DEFAULT 1000, CHECK >= 0 | Retry delay (ms) |
| BackoffStrategy | VARCHAR(20) | NOT NULL, DEFAULT 'Exponential' | Backoff strategy |
| CircuitBreakerEnabled | BOOLEAN | NOT NULL, DEFAULT FALSE | Circuit breaker enabled |
| FailureThreshold | INT | NULL, CHECK > 0 | Failure threshold for circuit breaker |
| RecoveryTimeout | INT | NULL, CHECK > 0 | Recovery timeout (ms) |
| ConnectionTimeout | INT | NOT NULL, DEFAULT 30000, CHECK > 0 | Connection timeout (ms) |
| ReadTimeout | INT | NOT NULL, DEFAULT 60000, CHECK > 0 | Read timeout (ms) |
| TotalTimeout | INT | NULL, CHECK > 0 | Total request timeout (ms) |
| KeepAliveEnabled | BOOLEAN | NOT NULL, DEFAULT TRUE | Keep-alive enabled |
| CompressionEnabled | BOOLEAN | NOT NULL, DEFAULT TRUE | Compression enabled |
| CachingEnabled | BOOLEAN | NOT NULL, DEFAULT FALSE | Response caching enabled |
| CacheExpirationMinutes | INT | NULL, CHECK >= 0 | Cache expiration period |
| LoggingEnabled | BOOLEAN | NOT NULL, DEFAULT TRUE | Request/response logging |
| LogLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Info' | Logging level |
| LogRequestHeaders | BOOLEAN | NOT NULL, DEFAULT FALSE | Log request headers |
| LogRequestBody | BOOLEAN | NOT NULL, DEFAULT FALSE | Log request body |
| LogResponseHeaders | BOOLEAN | NOT NULL, DEFAULT FALSE | Log response headers |
| LogResponseBody | BOOLEAN | NOT NULL, DEFAULT FALSE | Log response body |
| MonitoringEnabled | BOOLEAN | NOT NULL, DEFAULT TRUE | Monitoring enabled |
| HealthCheckEnabled | BOOLEAN | NOT NULL, DEFAULT TRUE | Health check enabled |
| HealthCheckInterval | INT | NOT NULL, DEFAULT 300, CHECK > 0 | Health check interval (seconds) |
| HealthCheckEndpoint | VARCHAR(500) | NULL | Health check endpoint |
| HealthCheckMethod | VARCHAR(10) | NULL | Health check HTTP method |
| ExpectedStatusCode | INT | NOT NULL, DEFAULT 200, CHECK >= 100 | Expected success status code |
| ExpectedResponseTime | INT | NULL, CHECK > 0 | Expected response time (ms) |
| AlertOnFailure | BOOLEAN | NOT NULL, DEFAULT TRUE | Alert on connection failure |
| AlertThreshold | INT | NOT NULL, DEFAULT 3, CHECK > 0 | Alert threshold |
| NotificationSettings | TEXT | NULL | Notification settings (JSON) |
| MaintenanceWindow | TEXT | NULL | Maintenance window (JSON) |
| ConnectionPool | TEXT | NULL | Connection pool settings |
| SecuritySettings | TEXT | NULL | Security settings (JSON) |
| ProxyConfiguration | TEXT | NULL | Proxy configuration (JSON) |
| FirewallRules | TEXT | NULL | Firewall rules (JSON) |
| WhitelistedIPs | TEXT | NULL | Whitelisted IP addresses |
| SSLVerification | BOOLEAN | NOT NULL, DEFAULT TRUE | SSL certificate verification |
| TLSVersion | VARCHAR(10) | NULL | Minimum TLS version |
| CipherSuites | TEXT | NULL | Allowed cipher suites |
| LastConnectionTest | TIMESTAMP | NULL | Last connection test |
| LastSuccessfulCall | TIMESTAMP | NULL | Last successful API call |
| LastFailedCall | TIMESTAMP | NULL | Last failed API call |
| TotalCallCount | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Total API calls made |
| SuccessCallCount | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Successful API calls |
| FailedCallCount | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Failed API calls |
| AverageResponseTime | DECIMAL(10,2) | NULL, CHECK >= 0 | Average response time (ms) |
| MinResponseTime | DECIMAL(10,2) | NULL, CHECK >= 0 | Minimum response time (ms) |
| MaxResponseTime | DECIMAL(10,2) | NULL, CHECK >= 0 | Maximum response time (ms) |
| TotalDataTransferred | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Total data transferred (bytes) |
| LastErrorCode | VARCHAR(20) | NULL | Last error code |
| LastErrorMessage | TEXT | NULL | Last error message |
| ConnectionStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Not Tested' | Connection status |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active connection flag |
| IsConfigured | BOOLEAN | NOT NULL, DEFAULT FALSE | Configuration complete |
| RequiresApproval | BOOLEAN | NOT NULL, DEFAULT TRUE | Approval required |
| ApprovalStatus | VARCHAR(20) | NULL | Approval status |
| ApprovedBy | VARCHAR(50) | FK, NULL | Approving user |
| ApprovalDate | TIMESTAMP | NULL | Approval date |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |
| NextHealthCheck | TIMESTAMP | NULL | Next health check time |

### Constraints

```sql
-- Primary Key
ALTER TABLE APIConnection ADD CONSTRAINT PK_APIConnection PRIMARY KEY (ConnectionId);

-- Foreign Keys
ALTER TABLE APIConnection ADD CONSTRAINT FK_APIConnection_DataSource 
    FOREIGN KEY (DataSourceId) REFERENCES ExternalDataSource(DataSourceId);
ALTER TABLE APIConnection ADD CONSTRAINT FK_APIConnection_ApprovedBy 
    FOREIGN KEY (ApprovedBy) REFERENCES UserProfile(UserId);

-- Check Constraints
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_ConnectionType 
    CHECK (ConnectionType IN ('REST', 'SOAP', 'GraphQL', 'gRPC', 'WebSocket', 'OData', 'Custom'));
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_HTTPMethod 
    CHECK (HTTPMethod IN ('GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'HEAD', 'OPTIONS'));
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_AuthenticationType 
    CHECK (AuthenticationType IN ('None', 'Basic', 'Bearer', 'OAuth1', 'OAuth2', 'API Key', 
                                  'Client Certificate', 'Custom', 'NTLM', 'Kerberos'));
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_TokenType 
    CHECK (TokenType IN ('Bearer', 'Basic', 'Custom', 'JWT') OR TokenType IS NULL);
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_PaginationType 
    CHECK (PaginationType IN ('Page Number', 'Offset', 'Cursor', 'Link Header') OR PaginationType IS NULL);
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_RateLimitPeriod 
    CHECK (RateLimitPeriod IN ('Second', 'Minute', 'Hour', 'Day', 'Month') OR RateLimitPeriod IS NULL);
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_BackoffStrategy 
    CHECK (BackoffStrategy IN ('Fixed', 'Linear', 'Exponential', 'Custom'));
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_ConnectionStatus 
    CHECK (ConnectionStatus IN ('Not Tested', 'Active', 'Failed', 'Timeout', 'Authentication Failed', 
                               'Rate Limited', 'Service Unavailable', 'Maintenance'));
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_ApprovalStatus 
    CHECK (ApprovalStatus IN ('Pending', 'Approved', 'Rejected', 'Under Review') OR ApprovalStatus IS NULL);
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_LogLevel 
    CHECK (LogLevel IN ('Trace', 'Debug', 'Info', 'Warn', 'Error', 'Fatal'));
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_HealthCheckMethod 
    CHECK (HealthCheckMethod IN ('GET', 'POST', 'HEAD', 'OPTIONS') OR HealthCheckMethod IS NULL);

-- Business Rules
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_PageSizes 
    CHECK (MaxPageSize IS NULL OR DefaultPageSize IS NULL OR MaxPageSize >= DefaultPageSize);
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_Timeouts 
    CHECK (TotalTimeout IS NULL OR TotalTimeout >= ConnectionTimeout);
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_ResponseTimes 
    CHECK (MinResponseTime IS NULL OR MaxResponseTime IS NULL OR MaxResponseTime >= MinResponseTime);
ALTER TABLE APIConnection ADD CONSTRAINT CK_APIConnection_CallCounts 
    CHECK (TotalCallCount >= (SuccessCallCount + FailedCallCount));
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_APIConnection_DataSourceId ON APIConnection(DataSourceId);
CREATE INDEX IX_APIConnection_ApprovedBy ON APIConnection(ApprovedBy);

-- Configuration Indexes
CREATE INDEX IX_APIConnection_ConnectionType ON APIConnection(ConnectionType);
CREATE INDEX IX_APIConnection_AuthenticationType ON APIConnection(AuthenticationType);
CREATE INDEX IX_APIConnection_HTTPMethod ON APIConnection(HTTPMethod);

-- Status Indexes
CREATE INDEX IX_APIConnection_ConnectionStatus ON APIConnection(ConnectionStatus);
CREATE INDEX IX_APIConnection_IsActive ON APIConnection(IsActive);
CREATE INDEX IX_APIConnection_IsConfigured ON APIConnection(IsConfigured);
CREATE INDEX IX_APIConnection_ApprovalStatus ON APIConnection(ApprovalStatus);

-- Performance Indexes
CREATE INDEX IX_APIConnection_AverageResponseTime ON APIConnection(AverageResponseTime);
CREATE INDEX IX_APIConnection_SuccessCallCount ON APIConnection(SuccessCallCount DESC);
CREATE INDEX IX_APIConnection_FailedCallCount ON APIConnection(FailedCallCount DESC);

-- Monitoring Indexes
CREATE INDEX IX_APIConnection_LastSuccessfulCall ON APIConnection(LastSuccessfulCall DESC);
CREATE INDEX IX_APIConnection_LastFailedCall ON APIConnection(LastFailedCall DESC);
CREATE INDEX IX_APIConnection_NextHealthCheck ON APIConnection(NextHealthCheck);

-- Boolean Capability Indexes
CREATE INDEX IX_APIConnection_MonitoringEnabled ON APIConnection(MonitoringEnabled);
CREATE INDEX IX_APIConnection_HealthCheckEnabled ON APIConnection(HealthCheckEnabled);
CREATE INDEX IX_APIConnection_RetryEnabled ON APIConnection(RetryEnabled);

-- Composite Indexes
CREATE INDEX IX_APIConnection_DataSource_Status ON APIConnection(DataSourceId, ConnectionStatus);
CREATE INDEX IX_APIConnection_Active_Type ON APIConnection(IsActive, ConnectionType);
CREATE INDEX IX_APIConnection_Status_ResponseTime ON APIConnection(ConnectionStatus, AverageResponseTime);
```

---

## Entity: DataSync

### Purpose
Tracking and management of data synchronization processes between external sources and internal systems.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| SyncId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| SyncJobId | VARCHAR(100) | UK, NOT NULL | Unique sync job identifier |
| DataSourceId | BIGINT | FK, NOT NULL | Reference to external data source |
| ConnectionId | BIGINT | FK, NULL | Reference to API connection |
| SyncType | VARCHAR(20) | NOT NULL | Full, Incremental, Delta |
| SyncDirection | VARCHAR(20) | NOT NULL, DEFAULT 'Import' | Import, Export, Bidirectional |
| SyncFrequency | VARCHAR(20) | NOT NULL | Manual, Scheduled, Real-time |
| ScheduleExpression | VARCHAR(100) | NULL | Cron expression for scheduling |
| NextScheduledRun | TIMESTAMP | NULL | Next scheduled execution |
| SyncScope | TEXT | NULL | Data scope definition (JSON) |
| FilterCriteria | TEXT | NULL | Filter criteria (JSON) |
| TransformationRules | TEXT | NULL | Transformation rules (JSON) |
| MappingRules | TEXT | NULL | Field mapping rules (JSON) |
| ValidationRules | TEXT | NULL | Validation rules (JSON) |
| ConflictResolutionStrategy | VARCHAR(30) | NOT NULL, DEFAULT 'Source Wins' | Conflict resolution strategy |
| DeduplicationStrategy | VARCHAR(30) | NOT NULL, DEFAULT 'Exact Match' | Deduplication strategy |
| ErrorHandlingStrategy | VARCHAR(30) | NOT NULL, DEFAULT 'Stop on Error' | Error handling approach |
| BatchSize | INT | NULL, CHECK > 0 | Processing batch size |
| MaxConcurrency | INT | NOT NULL, DEFAULT 1, CHECK > 0 | Maximum concurrent processes |
| TimeoutMinutes | INT | NOT NULL, DEFAULT 60, CHECK > 0 | Sync timeout in minutes |
| RetryAttempts | INT | NOT NULL, DEFAULT 3, CHECK >= 0 | Maximum retry attempts |
| RetryDelayMinutes | INT | NOT NULL, DEFAULT 5, CHECK >= 0 | Retry delay in minutes |
| StartedDate | TIMESTAMP | NULL | Sync start timestamp |
| CompletedDate | TIMESTAMP | NULL | Sync completion timestamp |
| DurationMinutes | DECIMAL(10,2) | NULL, CHECK >= 0 | Sync duration in minutes |
| SyncStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Not Started' | Current sync status |
| ExecutionMode | VARCHAR(20) | NOT NULL, DEFAULT 'Automatic' | Manual, Automatic, Debug |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active sync job flag |
| IsPaused | BOOLEAN | NOT NULL, DEFAULT FALSE | Paused sync job flag |
| IsConfigured | BOOLEAN | NOT NULL, DEFAULT FALSE | Configuration complete flag |
| RequiresApproval | BOOLEAN | NOT NULL, DEFAULT FALSE | Approval required flag |
| ApprovalStatus | VARCHAR(20) | NULL | Approval status |
| ApprovedBy | VARCHAR(50) | FK, NULL | Approving user |
| ApprovalDate | TIMESTAMP | NULL | Approval timestamp |
| RecordsToProcess | BIGINT | NULL, CHECK >= 0 | Total records to process |
| RecordsProcessed | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Records processed successfully |
| RecordsInserted | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Records inserted |
| RecordsUpdated | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Records updated |
| RecordsDeleted | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Records deleted |
| RecordsSkipped | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Records skipped |
| RecordsRejected | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Records rejected |
| RecordsWithErrors | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Records with errors |
| RecordsWithWarnings | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Records with warnings |
| DuplicatesFound | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Duplicate records found |
| ConflictsResolved | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Conflicts resolved |
| DataQualityIssues | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Data quality issues |
| ValidationFailures | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Validation failures |
| TransformationErrors | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Transformation errors |
| MappingErrors | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Mapping errors |
| BusinessRuleViolations | BIGINT | NOT NULL, DEFAULT 0, CHECK >= 0 | Business rule violations |
| DataSizeBytes | BIGINT | NULL, CHECK >= 0 | Total data size processed |
| ProcessingRate | DECIMAL(10,2) | NULL, CHECK >= 0 | Records per minute |
| ThroughputMBps | DECIMAL(10,4) | NULL, CHECK >= 0 | Throughput in MB/s |
| MemoryUsageMB | DECIMAL(10,2) | NULL, CHECK >= 0 | Peak memory usage |
| CPUUsagePercent | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Average CPU usage |
| NetworkBandwidthMBps | DECIMAL(10,4) | NULL, CHECK >= 0 | Network bandwidth used |
| DatabaseConnections | INT | NULL, CHECK >= 0 | Database connections used |
| TempStorageGB | DECIMAL(10,3) | NULL, CHECK >= 0 | Temporary storage used |
| CheckpointsCreated | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Recovery checkpoints created |
| LastCheckpointTimestamp | TIMESTAMP | NULL | Last checkpoint timestamp |
| LastCheckpointPosition | VARCHAR(500) | NULL | Last checkpoint position |
| LastProcessedId | VARCHAR(100) | NULL | Last processed record ID |
| LastProcessedTimestamp | TIMESTAMP | NULL | Last processed record timestamp |
| SourceSystemTimestamp | TIMESTAMP | NULL | Source system timestamp |
| SourceRecordCount | BIGINT | NULL, CHECK >= 0 | Source record count |
| TargetRecordCount | BIGINT | NULL, CHECK >= 0 | Target record count |
| DeltaRecordCount | BIGINT | NULL | Delta record count |
| ChangeDetectionMethod | VARCHAR(30) | NULL | Change detection method |
| ChangeToken | VARCHAR(500) | NULL | Change token/watermark |
| PreviousChangeToken | VARCHAR(500) | NULL | Previous change token |
| DataFreshness | VARCHAR(20) | NULL | Data freshness assessment |
| DataCompletenessPercent | DECIMAL(5,2) | NULL, CHECK BETWEEN 0 AND 100 | Data completeness percentage |
| DataQualityScore | DECIMAL(3,2) | NULL, CHECK BETWEEN 0 AND 1 | Overall data quality score |
| ErrorSummary | TEXT | NULL | Error summary |
| WarningSummary | TEXT | NULL | Warning summary |
| QualityReport | TEXT | NULL | Data quality report (JSON) |
| PerformanceMetrics | TEXT | NULL | Performance metrics (JSON) |
| ExecutionLog | TEXT | NULL | Execution log summary |
| DetailedErrorLog | TEXT | NULL | Detailed error information |
| TransformationLog | TEXT | NULL | Transformation log |
| ValidationLog | TEXT | NULL | Validation log |
| BusinessRuleLog | TEXT | NULL | Business rule processing log |
| NotificationsSent | TEXT | NULL | Notifications sent (JSON) |
| AlertsTriggered | TEXT | NULL | Alerts triggered (JSON) |
| EscalationsRequired | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Escalations required |
| ManualInterventionRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Manual intervention needed |
| InterventionReason | TEXT | NULL | Reason for intervention |
| ResumeFromCheckpoint | BOOLEAN | NOT NULL, DEFAULT FALSE | Resume from checkpoint flag |
| CleanupRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Cleanup required flag |
| ArchiveRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Archive required flag |
| ParentSyncId | BIGINT | FK, NULL | Parent sync job reference |
| ChildSyncCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Number of child sync jobs |
| DependencyCheck | TEXT | NULL | Dependency check results |
| PreConditions | TEXT | NULL | Pre-condition checks |
| PostConditions | TEXT | NULL | Post-condition validation |
| RollbackPlan | TEXT | NULL | Rollback plan |
| RecoveryPlan | TEXT | NULL | Recovery plan |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |
| TriggeredBy | VARCHAR(50) | FK, NULL | User who triggered sync |
| MonitoredBy | VARCHAR(50) | FK, NULL | User monitoring sync |

### Constraints

```sql
-- Primary Key
ALTER TABLE DataSync ADD CONSTRAINT PK_DataSync PRIMARY KEY (SyncId);

-- Unique Constraints
ALTER TABLE DataSync ADD CONSTRAINT UK_DataSync_SyncJobId UNIQUE (SyncJobId);

-- Foreign Keys
ALTER TABLE DataSync ADD CONSTRAINT FK_DataSync_DataSource 
    FOREIGN KEY (DataSourceId) REFERENCES ExternalDataSource(DataSourceId);
ALTER TABLE DataSync ADD CONSTRAINT FK_DataSync_Connection 
    FOREIGN KEY (ConnectionId) REFERENCES APIConnection(ConnectionId);
ALTER TABLE DataSync ADD CONSTRAINT FK_DataSync_ApprovedBy 
    FOREIGN KEY (ApprovedBy) REFERENCES UserProfile(UserId);
ALTER TABLE DataSync ADD CONSTRAINT FK_DataSync_ParentSync 
    FOREIGN KEY (ParentSyncId) REFERENCES DataSync(SyncId);
ALTER TABLE DataSync ADD CONSTRAINT FK_DataSync_TriggeredBy 
    FOREIGN KEY (TriggeredBy) REFERENCES UserProfile(UserId);
ALTER TABLE DataSync ADD CONSTRAINT FK_DataSync_MonitoredBy 
    FOREIGN KEY (MonitoredBy) REFERENCES UserProfile(UserId);

-- Check Constraints
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_SyncType 
    CHECK (SyncType IN ('Full', 'Incremental', 'Delta', 'Snapshot', 'Change Data Capture'));
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_SyncDirection 
    CHECK (SyncDirection IN ('Import', 'Export', 'Bidirectional', 'Sync'));
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_SyncFrequency 
    CHECK (SyncFrequency IN ('Manual', 'Scheduled', 'Real-time', 'Event-driven', 'On-demand'));
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_ConflictResolutionStrategy 
    CHECK (ConflictResolutionStrategy IN ('Source Wins', 'Target Wins', 'Latest Timestamp', 
                                         'Manual Resolution', 'Business Rules', 'Skip Conflict'));
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_DeduplicationStrategy 
    CHECK (DeduplicationStrategy IN ('Exact Match', 'Fuzzy Match', 'Business Key', 
                                    'Hash Comparison', 'Custom Rules', 'No Deduplication'));
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_ErrorHandlingStrategy 
    CHECK (ErrorHandlingStrategy IN ('Stop on Error', 'Skip Error', 'Log and Continue', 
                                    'Retry on Error', 'Manual Review', 'Quarantine'));
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_SyncStatus 
    CHECK (SyncStatus IN ('Not Started', 'Running', 'Completed', 'Failed', 'Paused', 
                         'Cancelled', 'Timeout', 'Error', 'Warning', 'Partial Success'));
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_ExecutionMode 
    CHECK (ExecutionMode IN ('Manual', 'Automatic', 'Debug', 'Test', 'Simulation'));
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_ApprovalStatus 
    CHECK (ApprovalStatus IN ('Pending', 'Approved', 'Rejected', 'Under Review') OR ApprovalStatus IS NULL);
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_ChangeDetectionMethod 
    CHECK (ChangeDetectionMethod IN ('Timestamp', 'Version', 'Hash', 'Change Token', 
                                    'Database Log', 'Custom') OR ChangeDetectionMethod IS NULL);
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_DataFreshness 
    CHECK (DataFreshness IN ('Real-time', 'Near Real-time', 'Fresh', 'Stale', 'Very Stale') OR DataFreshness IS NULL);

-- Business Rules
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_CompletedDate 
    CHECK (CompletedDate IS NULL OR StartedDate IS NULL OR CompletedDate >= StartedDate);
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_RecordCounts 
    CHECK (RecordsProcessed <= ISNULL(RecordsToProcess, RecordsProcessed));
ALTER TABLE DataSync ADD CONSTRAINT CK_DataSync_RecordBreakdown 
    CHECK (RecordsProcessed >= (RecordsInserted + RecordsUpdated + RecordsDeleted + RecordsSkipped));
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_DataSync_DataSourceId ON DataSync(DataSourceId);
CREATE INDEX IX_DataSync_ConnectionId ON DataSync(ConnectionId);
CREATE INDEX IX_DataSync_ApprovedBy ON DataSync(ApprovedBy);
CREATE INDEX IX_DataSync_ParentSyncId ON DataSync(ParentSyncId);
CREATE INDEX IX_DataSync_TriggeredBy ON DataSync(TriggeredBy);
CREATE INDEX IX_DataSync_MonitoredBy ON DataSync(MonitoredBy);

-- Status and Execution Indexes
CREATE INDEX IX_DataSync_SyncStatus ON DataSync(SyncStatus);
CREATE INDEX IX_DataSync_IsActive ON DataSync(IsActive);
CREATE INDEX IX_DataSync_IsPaused ON DataSync(IsPaused);
CREATE INDEX IX_DataSync_ExecutionMode ON DataSync(ExecutionMode);

-- Timing Indexes
CREATE INDEX IX_DataSync_StartedDate ON DataSync(StartedDate DESC);
CREATE INDEX IX_DataSync_CompletedDate ON DataSync(CompletedDate DESC);
CREATE INDEX IX_DataSync_NextScheduledRun ON DataSync(NextScheduledRun);
CREATE INDEX IX_DataSync_CreatedDate ON DataSync(CreatedDate DESC);

-- Configuration Indexes
CREATE INDEX IX_DataSync_SyncType ON DataSync(SyncType);
CREATE INDEX IX_DataSync_SyncFrequency ON DataSync(SyncFrequency);
CREATE INDEX IX_DataSync_SyncDirection ON DataSync(SyncDirection);

-- Performance Indexes
CREATE INDEX IX_DataSync_DurationMinutes ON DataSync(DurationMinutes DESC);
CREATE INDEX IX_DataSync_RecordsProcessed ON DataSync(RecordsProcessed DESC);
CREATE INDEX IX_DataSync_ProcessingRate ON DataSync(ProcessingRate DESC);

-- Quality and Error Indexes
CREATE INDEX IX_DataSync_DataQualityScore ON DataSync(DataQualityScore DESC);
CREATE INDEX IX_DataSync_RecordsWithErrors ON DataSync(RecordsWithErrors DESC);
CREATE INDEX IX_DataSync_ValidationFailures ON DataSync(ValidationFailures DESC);

-- Management Indexes
CREATE INDEX IX_DataSync_ManualInterventionRequired ON DataSync(ManualInterventionRequired);
CREATE INDEX IX_DataSync_CleanupRequired ON DataSync(CleanupRequired);
CREATE INDEX IX_DataSync_ArchiveRequired ON DataSync(ArchiveRequired);

-- Composite Indexes for Common Queries
CREATE INDEX IX_DataSync_DataSource_Status ON DataSync(DataSourceId, SyncStatus);
CREATE INDEX IX_DataSync_Active_Status ON DataSync(IsActive, SyncStatus);
CREATE INDEX IX_DataSync_Type_Status_Date ON DataSync(SyncType, SyncStatus, StartedDate DESC);
CREATE INDEX IX_DataSync_Source_Frequency_Next ON DataSync(DataSourceId, SyncFrequency, NextScheduledRun);
```

---

## Business Rules and Calculations

### Data Source Health Scoring

```sql
-- Function to calculate data source health score
CREATE FUNCTION CalculateDataSourceHealth(@DataSourceId BIGINT)
RETURNS DECIMAL(3,2)
AS
BEGIN
    DECLARE @HealthScore DECIMAL(3,2) = 0.0;
    DECLARE @ReliabilityScore DECIMAL(3,2) = 0.0;
    DECLARE @PerformanceScore DECIMAL(3,2) = 0.0;
    DECLARE @QualityScore DECIMAL(3,2) = 0.0;
    DECLARE @AvailabilityScore DECIMAL(3,2) = 0.0;
    
    -- Reliability Score (based on success rate)
    SELECT @ReliabilityScore = 
        CASE 
            WHEN ac.TotalCallCount = 0 THEN 0.5
            ELSE CAST(ac.SuccessCallCount AS DECIMAL) / ac.TotalCallCount
        END
    FROM APIConnection ac
    WHERE ac.DataSourceId = @DataSourceId;
    
    -- Performance Score (based on response time)
    SELECT @PerformanceScore = 
        CASE 
            WHEN ac.AverageResponseTime IS NULL THEN 0.5
            WHEN ac.AverageResponseTime <= 1000 THEN 1.0
            WHEN ac.AverageResponseTime <= 5000 THEN 0.8
            WHEN ac.AverageResponseTime <= 10000 THEN 0.6
            WHEN ac.AverageResponseTime <= 30000 THEN 0.4
            ELSE 0.2
        END
    FROM APIConnection ac
    WHERE ac.DataSourceId = @DataSourceId;
    
    -- Quality Score (from data source)
    SELECT @QualityScore = ISNULL(eds.DataQualityScore, 0.5)
    FROM ExternalDataSource eds
    WHERE eds.DataSourceId = @DataSourceId;
    
    -- Availability Score (based on recent sync success)
    SELECT @AvailabilityScore = 
        CASE 
            WHEN COUNT(CASE WHEN ds.SyncStatus = 'Completed' THEN 1 END) = 0 THEN 0.5
            ELSE CAST(COUNT(CASE WHEN ds.SyncStatus = 'Completed' THEN 1 END) AS DECIMAL) / COUNT(*)
        END
    FROM DataSync ds
    WHERE ds.DataSourceId = @DataSourceId
      AND ds.StartedDate >= DATEADD(day, -30, GETDATE());
    
    -- Calculate weighted health score
    SET @HealthScore = (
        (@ReliabilityScore * 0.3) + 
        (@PerformanceScore * 0.2) + 
        (@QualityScore * 0.3) + 
        (@AvailabilityScore * 0.2)
    );
    
    RETURN @HealthScore;
END;
```

### Integration Monitoring

```sql
-- Stored procedure to monitor integration health
CREATE PROCEDURE MonitorIntegrationHealth
AS
BEGIN
    -- Create temporary results table
    CREATE TABLE #IntegrationHealth (
        DataSourceId BIGINT,
        SourceName VARCHAR(255),
        HealthScore DECIMAL(3,2),
        Status VARCHAR(20),
        LastSync TIMESTAMP,
        ErrorCount INT,
        RecommendedAction TEXT
    );
    
    -- Calculate health scores for all active data sources
    INSERT INTO #IntegrationHealth
    SELECT 
        eds.DataSourceId,
        eds.SourceName,
        dbo.CalculateDataSourceHealth(eds.DataSourceId) AS HealthScore,
        CASE 
            WHEN dbo.CalculateDataSourceHealth(eds.DataSourceId) >= 0.8 THEN 'Healthy'
            WHEN dbo.CalculateDataSourceHealth(eds.DataSourceId) >= 0.6 THEN 'Warning'
            WHEN dbo.CalculateDataSourceHealth(eds.DataSourceId) >= 0.4 THEN 'Critical'
            ELSE 'Failed'
        END AS Status,
        eds.LastSuccessfulSync,
        eds.ErrorCount,
        CASE 
            WHEN dbo.CalculateDataSourceHealth(eds.DataSourceId) < 0.4 THEN 'Immediate investigation required'
            WHEN dbo.CalculateDataSourceHealth(eds.DataSourceId) < 0.6 THEN 'Monitor closely and investigate issues'
            WHEN dbo.CalculateDataSourceHealth(eds.DataSourceId) < 0.8 THEN 'Review performance and quality metrics'
            ELSE 'Continue monitoring'
        END AS RecommendedAction
    FROM ExternalDataSource eds
    WHERE eds.IsActive = 1;
    
    -- Return results
    SELECT * FROM #IntegrationHealth
    ORDER BY HealthScore ASC, ErrorCount DESC;
    
    -- Alert on critical issues
    IF EXISTS (SELECT 1 FROM #IntegrationHealth WHERE Status IN ('Critical', 'Failed'))
    BEGIN
        -- Trigger alerts (implementation would depend on alerting system)
        PRINT 'ALERT: Critical integration issues detected';
    END
    
    DROP TABLE #IntegrationHealth;
END;
```

### Sync Performance Analysis

```sql
-- View for sync performance analysis
CREATE VIEW SyncPerformanceView AS
SELECT 
    ds.DataSourceId,
    eds.SourceName,
    ds.SyncType,
    COUNT(*) AS TotalSyncs,
    COUNT(CASE WHEN ds.SyncStatus = 'Completed' THEN 1 END) AS SuccessfulSyncs,
    COUNT(CASE WHEN ds.SyncStatus = 'Failed' THEN 1 END) AS FailedSyncs,
    CAST(COUNT(CASE WHEN ds.SyncStatus = 'Completed' THEN 1 END) AS DECIMAL) / COUNT(*) AS SuccessRate,
    AVG(ds.DurationMinutes) AS AvgDurationMinutes,
    MIN(ds.DurationMinutes) AS MinDurationMinutes,
    MAX(ds.DurationMinutes) AS MaxDurationMinutes,
    AVG(ds.ProcessingRate) AS AvgProcessingRate,
    SUM(ds.RecordsProcessed) AS TotalRecordsProcessed,
    SUM(ds.RecordsWithErrors) AS TotalErrorRecords,
    AVG(ds.DataQualityScore) AS AvgDataQualityScore,
    MAX(ds.CompletedDate) AS LastSuccessfulSync,
    COUNT(CASE WHEN ds.ManualInterventionRequired = 1 THEN 1 END) AS InterventionsRequired
FROM DataSync ds
JOIN ExternalDataSource eds ON ds.DataSourceId = eds.DataSourceId
WHERE ds.StartedDate >= DATEADD(day, -90, GETDATE())
GROUP BY ds.DataSourceId, eds.SourceName, ds.SyncType;
```

---

## Data Quality Rules

### External Data Source Management
- Data source trust levels must be validated and reviewed quarterly
- Quality ratings must be updated based on actual performance metrics
- Geographic and industry coverage must be maintained accurately
- Contract and compliance information must be kept current

### API Connection Monitoring
- Connection health checks must be performed regularly
- Authentication credentials must be secured and rotated
- Rate limits must be monitored and respected
- Performance metrics must be tracked and analyzed

### Data Synchronization Control
- Sync jobs must have proper error handling and recovery procedures
- Data quality must be validated before and after synchronization
- Transformation and mapping rules must be tested and documented
- Conflict resolution must follow defined business rules

---

*Document Version*: 1.0  
*Last Updated*: August 21, 2025  
*Next Review*: September 21, 2025  
*Document Owner*: Integration Architecture Team
