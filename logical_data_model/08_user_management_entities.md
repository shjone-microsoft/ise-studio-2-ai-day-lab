# User Management Entities - Logical Data Model

## Overview
This document defines the logical structure for user profiles, role-based access control, and personalized system experiences for the Dynamic Supplier Diversification & Risk Scoring System.

---

## Entity: UserProfile

### Purpose
Central user identity and profile management with role-based access control and personalized system configuration.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| UserId | VARCHAR(50) | PK, NOT NULL | Primary user identifier |
| EmployeeId | VARCHAR(50) | UK, NULL | Employee identifier |
| FirstName | VARCHAR(100) | NOT NULL | User first name |
| LastName | VARCHAR(100) | NOT NULL | User last name |
| MiddleName | VARCHAR(100) | NULL | User middle name |
| DisplayName | VARCHAR(255) | NULL | Preferred display name |
| EmailAddress | VARCHAR(255) | UK, NOT NULL | Primary email address |
| AlternateEmail | VARCHAR(255) | NULL | Alternate email address |
| PhoneNumber | VARCHAR(50) | NULL | Primary phone number |
| MobileNumber | VARCHAR(50) | NULL | Mobile phone number |
| OfficeLocation | VARCHAR(255) | NULL | Office location |
| Department | VARCHAR(100) | NOT NULL | Department or division |
| BusinessUnit | VARCHAR(100) | NULL | Business unit |
| JobTitle | VARCHAR(255) | NOT NULL | Job title or position |
| JobLevel | VARCHAR(50) | NULL | Job level or grade |
| ManagerUserId | VARCHAR(50) | FK, NULL | Direct manager |
| ManagerialLevel | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Managerial level (0=individual contributor) |
| CostCenter | VARCHAR(50) | NULL | Cost center assignment |
| PrimaryRole | VARCHAR(50) | FK, NOT NULL | Primary system role |
| SecondaryRoles | TEXT | NULL | Additional roles (JSON array) |
| UserStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Active' | User account status |
| HireDate | DATE | NULL | Employee hire date |
| TerminationDate | DATE | NULL | Employee termination date |
| LastLoginDate | TIMESTAMP | NULL | Last system login |
| LoginCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Total login count |
| PasswordLastChanged | TIMESTAMP | NULL | Last password change |
| MustChangePassword | BOOLEAN | NOT NULL, DEFAULT FALSE | Password change required |
| IsLockedOut | BOOLEAN | NOT NULL, DEFAULT FALSE | Account lockout status |
| LockoutDate | TIMESTAMP | NULL | Account lockout timestamp |
| FailedLoginAttempts | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Failed login attempts |
| PreferredLanguage | VARCHAR(2) | FK, NOT NULL, DEFAULT 'EN' | Preferred language |
| PreferredCurrency | VARCHAR(3) | FK, NULL | Preferred currency |
| TimeZone | VARCHAR(50) | NOT NULL, DEFAULT 'UTC' | User time zone |
| DateFormat | VARCHAR(20) | NOT NULL, DEFAULT 'MM/DD/YYYY' | Preferred date format |
| NumberFormat | VARCHAR(20) | NOT NULL, DEFAULT 'US' | Preferred number format |
| DefaultDashboard | VARCHAR(50) | NULL | Default dashboard view |
| NotificationPreferences | TEXT | NULL | Notification settings (JSON) |
| AlertPreferences | TEXT | NULL | Alert settings (JSON) |
| ReportSubscriptions | TEXT | NULL | Report subscriptions (JSON) |
| DashboardConfiguration | TEXT | NULL | Dashboard configuration (JSON) |
| UserPreferences | TEXT | NULL | Additional user preferences (JSON) |
| CategoryAssignments | TEXT | NULL | Assigned product categories (JSON) |
| RegionAssignments | TEXT | NULL | Assigned geographic regions (JSON) |
| SupplierAssignments | TEXT | NULL | Assigned suppliers (JSON) |
| AccessScope | VARCHAR(20) | NOT NULL, DEFAULT 'Standard' | Access scope level |
| ApprovalAuthority | DECIMAL(19,4) | NULL, CHECK >= 0 | Approval authority limit |
| ApprovalCurrency | VARCHAR(3) | FK, NULL | Approval authority currency |
| DelegationEnabled | BOOLEAN | NOT NULL, DEFAULT TRUE | Delegation capability |
| DelegateUserId | VARCHAR(50) | FK, NULL | Delegated user |
| DelegationStartDate | DATE | NULL | Delegation start date |
| DelegationEndDate | DATE | NULL | Delegation end date |
| PerformanceTargets | TEXT | NULL | Performance targets (JSON) |
| KPIAssignments | TEXT | NULL | KPI assignments (JSON) |
| SkillsAndCertifications | TEXT | NULL | Skills and certifications (JSON) |
| TrainingCompletions | TEXT | NULL | Training completions (JSON) |
| SystemAccess | TEXT | NULL | System access permissions (JSON) |
| DataClassificationLevel | VARCHAR(20) | NOT NULL, DEFAULT 'Standard' | Data access classification |
| SecurityClearance | VARCHAR(20) | NULL | Security clearance level |
| ComplianceTrainingStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Required' | Compliance training status |
| LastComplianceTraining | DATE | NULL | Last compliance training date |
| AuditTrailEnabled | BOOLEAN | NOT NULL, DEFAULT TRUE | Audit trail tracking |
| SessionTimeout | INT | NOT NULL, DEFAULT 480, CHECK > 0 | Session timeout in minutes |
| ConcurrentSessionsAllowed | INT | NOT NULL, DEFAULT 3, CHECK > 0 | Maximum concurrent sessions |
| IPRestrictions | TEXT | NULL | IP address restrictions |
| DeviceRestrictions | TEXT | NULL | Device access restrictions |
| TwoFactorEnabled | BOOLEAN | NOT NULL, DEFAULT FALSE | Two-factor authentication |
| TwoFactorSecret | VARCHAR(255) | NULL | Two-factor authentication secret |
| BackupCodes | TEXT | NULL | Two-factor backup codes |
| PrivacySettings | TEXT | NULL | Privacy preferences (JSON) |
| DataSharingConsent | BOOLEAN | NOT NULL, DEFAULT FALSE | Data sharing consent |
| TermsAcceptanceDate | TIMESTAMP | NULL | Terms of service acceptance |
| PrivacyPolicyAcceptance | TIMESTAMP | NULL | Privacy policy acceptance |
| PersonalDataProcessingConsent | BOOLEAN | NOT NULL, DEFAULT FALSE | Personal data processing consent |
| MarketingConsent | BOOLEAN | NOT NULL, DEFAULT FALSE | Marketing communication consent |
| IsTestUser | BOOLEAN | NOT NULL, DEFAULT FALSE | Test user account flag |
| IsServiceAccount | BOOLEAN | NOT NULL, DEFAULT FALSE | Service account flag |
| IsExternalUser | BOOLEAN | NOT NULL, DEFAULT FALSE | External user flag |
| ExternalOrganization | VARCHAR(255) | NULL | External organization name |
| ContractorCompany | VARCHAR(255) | NULL | Contractor company name |
| ContractEndDate | DATE | NULL | Contract end date |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |
| LastProfileUpdate | TIMESTAMP | NULL | Last profile update by user |

### Constraints

```sql
-- Primary Key
ALTER TABLE UserProfile ADD CONSTRAINT PK_UserProfile PRIMARY KEY (UserId);

-- Unique Constraints
ALTER TABLE UserProfile ADD CONSTRAINT UK_UserProfile_EmployeeId UNIQUE (EmployeeId);
ALTER TABLE UserProfile ADD CONSTRAINT UK_UserProfile_EmailAddress UNIQUE (EmailAddress);

-- Foreign Keys
ALTER TABLE UserProfile ADD CONSTRAINT FK_UserProfile_Manager 
    FOREIGN KEY (ManagerUserId) REFERENCES UserProfile(UserId);
ALTER TABLE UserProfile ADD CONSTRAINT FK_UserProfile_PrimaryRole 
    FOREIGN KEY (PrimaryRole) REFERENCES UserRole(RoleCode);
ALTER TABLE UserProfile ADD CONSTRAINT FK_UserProfile_PreferredLanguage 
    FOREIGN KEY (PreferredLanguage) REFERENCES Language(LanguageCode);
ALTER TABLE UserProfile ADD CONSTRAINT FK_UserProfile_PreferredCurrency 
    FOREIGN KEY (PreferredCurrency) REFERENCES Currency(CurrencyCode);
ALTER TABLE UserProfile ADD CONSTRAINT FK_UserProfile_ApprovalCurrency 
    FOREIGN KEY (ApprovalCurrency) REFERENCES Currency(CurrencyCode);
ALTER TABLE UserProfile ADD CONSTRAINT FK_UserProfile_Delegate 
    FOREIGN KEY (DelegateUserId) REFERENCES UserProfile(UserId);

-- Check Constraints
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_UserStatus 
    CHECK (UserStatus IN ('Active', 'Inactive', 'Suspended', 'Terminated', 'Locked', 'Pending Activation'));
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_AccessScope 
    CHECK (AccessScope IN ('Global', 'Regional', 'Category', 'Limited', 'Standard', 'Restricted'));
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_DataClassificationLevel 
    CHECK (DataClassificationLevel IN ('Public', 'Internal', 'Confidential', 'Restricted', 'Standard'));
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_ComplianceTrainingStatus 
    CHECK (ComplianceTrainingStatus IN ('Current', 'Expired', 'Required', 'Overdue', 'Not Required'));
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_SecurityClearance 
    CHECK (SecurityClearance IN ('Public', 'Confidential', 'Secret', 'Top Secret') OR SecurityClearance IS NULL);

-- Business Rules
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_EmailFormat 
    CHECK (EmailAddress LIKE '%@%.%');
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_AlternateEmailFormat 
    CHECK (AlternateEmail LIKE '%@%.%' OR AlternateEmail IS NULL);
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_ManagerNotSelf 
    CHECK (ManagerUserId != UserId);
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_DelegateNotSelf 
    CHECK (DelegateUserId != UserId);
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_TerminationDate 
    CHECK (TerminationDate IS NULL OR TerminationDate >= HireDate);
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_DelegationDates 
    CHECK (DelegationEndDate IS NULL OR DelegationStartDate IS NULL OR DelegationEndDate >= DelegationStartDate);
ALTER TABLE UserProfile ADD CONSTRAINT CK_UserProfile_ContractEndDate 
    CHECK (ContractEndDate IS NULL OR IsExternalUser = 1);
```

### Indexes

```sql
-- Unique Key Indexes (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_UserProfile_ManagerUserId ON UserProfile(ManagerUserId);
CREATE INDEX IX_UserProfile_PrimaryRole ON UserProfile(PrimaryRole);
CREATE INDEX IX_UserProfile_PreferredLanguage ON UserProfile(PreferredLanguage);
CREATE INDEX IX_UserProfile_PreferredCurrency ON UserProfile(PreferredCurrency);
CREATE INDEX IX_UserProfile_ApprovalCurrency ON UserProfile(ApprovalCurrency);
CREATE INDEX IX_UserProfile_DelegateUserId ON UserProfile(DelegateUserId);

-- Search and Filter Indexes
CREATE INDEX IX_UserProfile_UserStatus ON UserProfile(UserStatus);
CREATE INDEX IX_UserProfile_Department ON UserProfile(Department);
CREATE INDEX IX_UserProfile_JobTitle ON UserProfile(JobTitle);
CREATE INDEX IX_UserProfile_AccessScope ON UserProfile(AccessScope);

-- Name Search Indexes
CREATE INDEX IX_UserProfile_LastName ON UserProfile(LastName);
CREATE INDEX IX_UserProfile_FirstName ON UserProfile(FirstName);
CREATE INDEX IX_UserProfile_DisplayName ON UserProfile(DisplayName);

-- Date-based Indexes
CREATE INDEX IX_UserProfile_HireDate ON UserProfile(HireDate);
CREATE INDEX IX_UserProfile_TerminationDate ON UserProfile(TerminationDate);
CREATE INDEX IX_UserProfile_LastLoginDate ON UserProfile(LastLoginDate DESC);

-- Security and Access Indexes
CREATE INDEX IX_UserProfile_IsLockedOut ON UserProfile(IsLockedOut);
CREATE INDEX IX_UserProfile_TwoFactorEnabled ON UserProfile(TwoFactorEnabled);
CREATE INDEX IX_UserProfile_DataClassificationLevel ON UserProfile(DataClassificationLevel);

-- Boolean Flag Indexes
CREATE INDEX IX_UserProfile_IsTestUser ON UserProfile(IsTestUser);
CREATE INDEX IX_UserProfile_IsServiceAccount ON UserProfile(IsServiceAccount);
CREATE INDEX IX_UserProfile_IsExternalUser ON UserProfile(IsExternalUser);

-- Composite Indexes for Common Queries
CREATE INDEX IX_UserProfile_Status_Department ON UserProfile(UserStatus, Department);
CREATE INDEX IX_UserProfile_Role_Status ON UserProfile(PrimaryRole, UserStatus);
CREATE INDEX IX_UserProfile_Manager_Status ON UserProfile(ManagerUserId, UserStatus);
CREATE INDEX IX_UserProfile_Active_Login ON UserProfile(UserStatus, LastLoginDate DESC);

-- Full-text indexes for name searches (if supported)
CREATE FULLTEXT INDEX FTI_UserProfile_Names ON UserProfile(FirstName, LastName, DisplayName);
```

---

## Entity: UserRole

### Purpose
Defines system roles with associated permissions and capabilities for role-based access control.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| RoleId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| RoleCode | VARCHAR(50) | UK, NOT NULL | Role identifier code |
| RoleName | VARCHAR(255) | NOT NULL | Role display name |
| RoleDescription | TEXT | NOT NULL | Detailed role description |
| RoleType | VARCHAR(20) | NOT NULL | Functional, Administrative, etc. |
| RoleCategory | VARCHAR(30) | NOT NULL | Executive, Management, Analyst, etc. |
| ParentRoleCode | VARCHAR(50) | FK, NULL | Parent role for hierarchy |
| RoleLevel | INT | NOT NULL, DEFAULT 1 | Role hierarchy level |
| ResponsibilityScope | VARCHAR(20) | NOT NULL | Global, Regional, Category, etc. |
| DataAccessLevel | VARCHAR(20) | NOT NULL | Data access classification |
| FunctionalAreas | TEXT | NOT NULL | Functional area access (JSON) |
| SystemPermissions | TEXT | NOT NULL | System permissions (JSON) |
| DataPermissions | TEXT | NOT NULL | Data access permissions (JSON) |
| FeaturePermissions | TEXT | NOT NULL | Feature access permissions (JSON) |
| ReportAccess | TEXT | NULL | Report access permissions (JSON) |
| DashboardAccess | TEXT | NULL | Dashboard access permissions (JSON) |
| WorkflowPermissions | TEXT | NULL | Workflow permissions (JSON) |
| ApprovalPermissions | TEXT | NULL | Approval permissions (JSON) |
| MaxApprovalAmount | DECIMAL(19,4) | NULL, CHECK >= 0 | Maximum approval amount |
| ApprovalCurrency | VARCHAR(3) | FK, NULL | Approval currency |
| DelegationAllowed | BOOLEAN | NOT NULL, DEFAULT TRUE | Delegation capability |
| BulkOperationsAllowed | BOOLEAN | NOT NULL, DEFAULT FALSE | Bulk operations permission |
| DataExportAllowed | BOOLEAN | NOT NULL, DEFAULT FALSE | Data export permission |
| APIAccessAllowed | BOOLEAN | NOT NULL, DEFAULT FALSE | API access permission |
| IntegrationAccess | TEXT | NULL | Integration access permissions |
| SecurityRequirements | TEXT | NULL | Special security requirements |
| ComplianceRequirements | TEXT | NULL | Compliance requirements |
| TrainingRequirements | TEXT | NULL | Required training (JSON) |
| CertificationRequirements | TEXT | NULL | Required certifications |
| WorkingHoursRestriction | TEXT | NULL | Working hours restrictions |
| GeographicRestrictions | TEXT | NULL | Geographic access restrictions |
| IPRestrictions | TEXT | NULL | IP address restrictions |
| DeviceRestrictions | TEXT | NULL | Device access restrictions |
| SessionTimeoutMinutes | INT | NOT NULL, DEFAULT 480, CHECK > 0 | Session timeout |
| ConcurrentSessionsAllowed | INT | NOT NULL, DEFAULT 5, CHECK > 0 | Max concurrent sessions |
| MustUseTwoFactor | BOOLEAN | NOT NULL, DEFAULT FALSE | Two-factor authentication required |
| PasswordComplexityLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Standard' | Password complexity requirement |
| PasswordExpirationDays | INT | NULL, CHECK > 0 | Password expiration period |
| AuditLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Standard' | Audit logging level |
| MonitoringLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Standard' | Activity monitoring level |
| NotificationSettings | TEXT | NULL | Default notification settings |
| DefaultDashboard | VARCHAR(50) | NULL | Default dashboard |
| DefaultReports | TEXT | NULL | Default reports (JSON) |
| MenuConfiguration | TEXT | NULL | Menu configuration (JSON) |
| WorkspaceConfiguration | TEXT | NULL | Workspace configuration (JSON) |
| BusinessJustification | TEXT | NOT NULL | Role business justification |
| RiskLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Standard' | Role risk assessment |
| ComplianceClassification | VARCHAR(20) | NOT NULL | Compliance classification |
| DataRetentionRequirements | TEXT | NULL | Data retention requirements |
| PrivacyRequirements | TEXT | NULL | Privacy protection requirements |
| CreatedBy | VARCHAR(50) | NOT NULL | Role creator |
| ReviewedBy | VARCHAR(50) | FK, NULL | Role reviewer |
| ApprovedBy | VARCHAR(50) | FK, NULL | Role approver |
| ApprovalDate | TIMESTAMP | NULL | Role approval date |
| EffectiveDate | DATE | NOT NULL | Role effective date |
| ExpirationDate | DATE | NULL | Role expiration date |
| LastReviewDate | DATE | NULL | Last role review |
| NextReviewDate | DATE | NOT NULL | Next scheduled review |
| UserCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Number of users with role |
| MaxUserCount | INT | NULL, CHECK > 0 | Maximum users allowed |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active role flag |
| IsDefault | BOOLEAN | NOT NULL, DEFAULT FALSE | Default role flag |
| IsCustom | BOOLEAN | NOT NULL, DEFAULT FALSE | Custom role flag |
| RequiresApproval | BOOLEAN | NOT NULL, DEFAULT TRUE | Assignment approval required |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE UserRole ADD CONSTRAINT PK_UserRole PRIMARY KEY (RoleId);

-- Unique Constraints
ALTER TABLE UserRole ADD CONSTRAINT UK_UserRole_RoleCode UNIQUE (RoleCode);

-- Foreign Keys
ALTER TABLE UserRole ADD CONSTRAINT FK_UserRole_ParentRole 
    FOREIGN KEY (ParentRoleCode) REFERENCES UserRole(RoleCode);
ALTER TABLE UserRole ADD CONSTRAINT FK_UserRole_ApprovalCurrency 
    FOREIGN KEY (ApprovalCurrency) REFERENCES Currency(CurrencyCode);
ALTER TABLE UserRole ADD CONSTRAINT FK_UserRole_ReviewedBy 
    FOREIGN KEY (ReviewedBy) REFERENCES UserProfile(UserId);
ALTER TABLE UserRole ADD CONSTRAINT FK_UserRole_ApprovedBy 
    FOREIGN KEY (ApprovedBy) REFERENCES UserProfile(UserId);

-- Check Constraints
ALTER TABLE UserRole ADD CONSTRAINT CK_UserRole_RoleType 
    CHECK (RoleType IN ('Functional', 'Administrative', 'Technical', 'Executive', 'Support'));
ALTER TABLE UserRole ADD CONSTRAINT CK_UserRole_RoleCategory 
    CHECK (RoleCategory IN ('Executive', 'Senior Management', 'Management', 'Analyst', 
                           'Specialist', 'Administrator', 'Support', 'External'));
ALTER TABLE UserRole ADD CONSTRAINT CK_UserRole_ResponsibilityScope 
    CHECK (ResponsibilityScope IN ('Global', 'Regional', 'Country', 'Category', 'Supplier', 
                                   'Department', 'Team', 'Individual', 'Limited'));
ALTER TABLE UserRole ADD CONSTRAINT CK_UserRole_DataAccessLevel 
    CHECK (DataAccessLevel IN ('Full', 'Partial', 'Limited', 'Read-Only', 'None'));
ALTER TABLE UserRole ADD CONSTRAINT CK_UserRole_RiskLevel 
    CHECK (RiskLevel IN ('Low', 'Standard', 'Elevated', 'High', 'Critical'));
ALTER TABLE UserRole ADD CONSTRAINT CK_UserRole_PasswordComplexityLevel 
    CHECK (PasswordComplexityLevel IN ('Basic', 'Standard', 'High', 'Maximum'));
ALTER TABLE UserRole ADD CONSTRAINT CK_UserRole_AuditLevel 
    CHECK (AuditLevel IN ('Minimal', 'Standard', 'Detailed', 'Maximum'));

-- Business Rules
ALTER TABLE UserRole ADD CONSTRAINT CK_UserRole_ExpirationDate 
    CHECK (ExpirationDate IS NULL OR ExpirationDate > EffectiveDate);
ALTER TABLE UserRole ADD CONSTRAINT CK_UserRole_NextReviewDate 
    CHECK (NextReviewDate > EffectiveDate);
ALTER TABLE UserRole ADD CONSTRAINT CK_UserRole_MaxUserCount 
    CHECK (MaxUserCount IS NULL OR MaxUserCount >= UserCount);
ALTER TABLE UserRole ADD CONSTRAINT CK_UserRole_ApprovalDate 
    CHECK (ApprovalDate IS NULL OR ApprovalDate <= EffectiveDate);
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_UserRole_ParentRoleCode ON UserRole(ParentRoleCode);
CREATE INDEX IX_UserRole_ApprovalCurrency ON UserRole(ApprovalCurrency);
CREATE INDEX IX_UserRole_ReviewedBy ON UserRole(ReviewedBy);
CREATE INDEX IX_UserRole_ApprovedBy ON UserRole(ApprovedBy);

-- Classification Indexes
CREATE INDEX IX_UserRole_RoleType ON UserRole(RoleType);
CREATE INDEX IX_UserRole_RoleCategory ON UserRole(RoleCategory);
CREATE INDEX IX_UserRole_ResponsibilityScope ON UserRole(ResponsibilityScope);
CREATE INDEX IX_UserRole_DataAccessLevel ON UserRole(DataAccessLevel);

-- Security and Risk Indexes
CREATE INDEX IX_UserRole_RiskLevel ON UserRole(RiskLevel);
CREATE INDEX IX_UserRole_ComplianceClassification ON UserRole(ComplianceClassification);
CREATE INDEX IX_UserRole_MustUseTwoFactor ON UserRole(MustUseTwoFactor);

-- Date-based Indexes
CREATE INDEX IX_UserRole_EffectiveDate ON UserRole(EffectiveDate DESC);
CREATE INDEX IX_UserRole_ExpirationDate ON UserRole(ExpirationDate);
CREATE INDEX IX_UserRole_NextReviewDate ON UserRole(NextReviewDate);

-- Performance Indexes
CREATE INDEX IX_UserRole_UserCount ON UserRole(UserCount DESC);
CREATE INDEX IX_UserRole_MaxApprovalAmount ON UserRole(MaxApprovalAmount DESC);

-- Boolean Flag Indexes
CREATE INDEX IX_UserRole_IsActive ON UserRole(IsActive);
CREATE INDEX IX_UserRole_IsDefault ON UserRole(IsDefault);
CREATE INDEX IX_UserRole_IsCustom ON UserRole(IsCustom);

-- Composite Indexes
CREATE INDEX IX_UserRole_Active_Type ON UserRole(IsActive, RoleType);
CREATE INDEX IX_UserRole_Category_Scope ON UserRole(RoleCategory, ResponsibilityScope);
CREATE INDEX IX_UserRole_Risk_Access ON UserRole(RiskLevel, DataAccessLevel);
```

---

## Entity: UserSession

### Purpose
Tracks active user sessions for security monitoring, concurrent session management, and audit purposes.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| SessionId | VARCHAR(128) | PK, NOT NULL | System-generated session identifier |
| UserId | VARCHAR(50) | FK, NOT NULL | Reference to user |
| SessionToken | VARCHAR(512) | UK, NOT NULL | Secure session token |
| LoginTimestamp | TIMESTAMP | NOT NULL | Session start time |
| LastActivityTimestamp | TIMESTAMP | NOT NULL | Last activity time |
| ExpiryTimestamp | TIMESTAMP | NOT NULL | Session expiry time |
| IPAddress | VARCHAR(45) | NOT NULL | Client IP address |
| UserAgent | VARCHAR(1000) | NULL | Client user agent string |
| DeviceType | VARCHAR(50) | NULL | Device type (Desktop, Mobile, etc.) |
| DeviceOS | VARCHAR(100) | NULL | Operating system |
| BrowserName | VARCHAR(100) | NULL | Browser name |
| BrowserVersion | VARCHAR(50) | NULL | Browser version |
| LocationCity | VARCHAR(100) | NULL | Geographic location (city) |
| LocationCountry | VARCHAR(100) | NULL | Geographic location (country) |
| LocationRegion | VARCHAR(100) | NULL | Geographic location (region) |
| ISPProvider | VARCHAR(255) | NULL | Internet service provider |
| ConnectionType | VARCHAR(50) | NULL | Connection type |
| LoginMethod | VARCHAR(20) | NOT NULL | SSO, Username/Password, etc. |
| TwoFactorUsed | BOOLEAN | NOT NULL, DEFAULT FALSE | Two-factor authentication used |
| SessionType | VARCHAR(20) | NOT NULL, DEFAULT 'Interactive' | Interactive, API, Service |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active session flag |
| IsSecure | BOOLEAN | NOT NULL, DEFAULT TRUE | Secure connection flag |
| IsMobile | BOOLEAN | NOT NULL, DEFAULT FALSE | Mobile device flag |
| IsRemote | BOOLEAN | NOT NULL, DEFAULT FALSE | Remote access flag |
| LogoutTimestamp | TIMESTAMP | NULL | Session end time |
| LogoutReason | VARCHAR(50) | NULL | Logout reason |
| TimeoutOccurred | BOOLEAN | NOT NULL, DEFAULT FALSE | Session timeout flag |
| ForcedLogout | BOOLEAN | NOT NULL, DEFAULT FALSE | Forced logout flag |
| SuspiciousActivity | BOOLEAN | NOT NULL, DEFAULT FALSE | Suspicious activity flag |
| FailedLoginAttempts | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Failed login attempts |
| SuccessfulLoginAttempts | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Successful login attempts |
| PageViewCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Page views in session |
| ActionCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Actions performed in session |
| DataDownloadCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Data downloads in session |
| ErrorCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Errors encountered |
| WarningCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Warnings generated |
| SecurityViolations | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Security violations |
| ComplianceViolations | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Compliance violations |
| LastAccessedFeature | VARCHAR(100) | NULL | Last accessed feature |
| LastAccessedPage | VARCHAR(255) | NULL | Last accessed page |
| SessionData | TEXT | NULL | Session data (JSON) |
| SecurityAttributes | TEXT | NULL | Security attributes (JSON) |
| PerformanceMetrics | TEXT | NULL | Performance metrics (JSON) |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |

### Constraints

```sql
-- Primary Key
ALTER TABLE UserSession ADD CONSTRAINT PK_UserSession PRIMARY KEY (SessionId);

-- Unique Constraints
ALTER TABLE UserSession ADD CONSTRAINT UK_UserSession_SessionToken UNIQUE (SessionToken);

-- Foreign Keys
ALTER TABLE UserSession ADD CONSTRAINT FK_UserSession_User 
    FOREIGN KEY (UserId) REFERENCES UserProfile(UserId);

-- Check Constraints
ALTER TABLE UserSession ADD CONSTRAINT CK_UserSession_LoginMethod 
    CHECK (LoginMethod IN ('Username/Password', 'SSO', 'SAML', 'OAuth', 'API Key', 'Certificate', 'Token'));
ALTER TABLE UserSession ADD CONSTRAINT CK_UserSession_SessionType 
    CHECK (SessionType IN ('Interactive', 'API', 'Service', 'Background', 'Mobile App'));
ALTER TABLE UserSession ADD CONSTRAINT CK_UserSession_LogoutReason 
    CHECK (LogoutReason IN ('User Logout', 'Timeout', 'Forced', 'Security', 'System Maintenance', 'Error') OR LogoutReason IS NULL);

-- Business Rules
ALTER TABLE UserSession ADD CONSTRAINT CK_UserSession_ExpiryTime 
    CHECK (ExpiryTimestamp > LoginTimestamp);
ALTER TABLE UserSession ADD CONSTRAINT CK_UserSession_LastActivity 
    CHECK (LastActivityTimestamp >= LoginTimestamp);
ALTER TABLE UserSession ADD CONSTRAINT CK_UserSession_LogoutTime 
    CHECK (LogoutTimestamp IS NULL OR LogoutTimestamp >= LoginTimestamp);
```

### Indexes

```sql
-- Unique Key Index (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_UserSession_UserId ON UserSession(UserId);

-- Session Management Indexes
CREATE INDEX IX_UserSession_IsActive ON UserSession(IsActive);
CREATE INDEX IX_UserSession_LoginTimestamp ON UserSession(LoginTimestamp DESC);
CREATE INDEX IX_UserSession_ExpiryTimestamp ON UserSession(ExpiryTimestamp);
CREATE INDEX IX_UserSession_LastActivityTimestamp ON UserSession(LastActivityTimestamp DESC);

-- Security Monitoring Indexes
CREATE INDEX IX_UserSession_IPAddress ON UserSession(IPAddress);
CREATE INDEX IX_UserSession_SuspiciousActivity ON UserSession(SuspiciousActivity);
CREATE INDEX IX_UserSession_SecurityViolations ON UserSession(SecurityViolations);
CREATE INDEX IX_UserSession_TwoFactorUsed ON UserSession(TwoFactorUsed);

-- Device and Location Indexes
CREATE INDEX IX_UserSession_DeviceType ON UserSession(DeviceType);
CREATE INDEX IX_UserSession_IsMobile ON UserSession(IsMobile);
CREATE INDEX IX_UserSession_IsRemote ON UserSession(IsRemote);
CREATE INDEX IX_UserSession_LocationCountry ON UserSession(LocationCountry);

-- Session Type and Method Indexes
CREATE INDEX IX_UserSession_LoginMethod ON UserSession(LoginMethod);
CREATE INDEX IX_UserSession_SessionType ON UserSession(SessionType);

-- Composite Indexes for Common Queries
CREATE INDEX IX_UserSession_User_Active ON UserSession(UserId, IsActive);
CREATE INDEX IX_UserSession_Active_Expiry ON UserSession(IsActive, ExpiryTimestamp);
CREATE INDEX IX_UserSession_User_Login ON UserSession(UserId, LoginTimestamp DESC);
CREATE INDEX IX_UserSession_IP_Suspicious ON UserSession(IPAddress, SuspiciousActivity);

-- Partitioning by LoginTimestamp (daily partitions for performance)
-- Implementation depends on database system
```

---

## Entity: UserActivityLog

### Purpose
Comprehensive audit trail of user activities for security monitoring, compliance, and performance analysis.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| ActivityId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| UserId | VARCHAR(50) | FK, NOT NULL | Reference to user |
| SessionId | VARCHAR(128) | FK, NULL | Reference to user session |
| ActivityTimestamp | TIMESTAMP | NOT NULL | Activity timestamp |
| ActivityType | VARCHAR(50) | NOT NULL | Login, Logout, View, Edit, etc. |
| ActivityCategory | VARCHAR(30) | NOT NULL | Security, Data Access, etc. |
| ActivityDescription | TEXT | NOT NULL | Detailed activity description |
| FeatureAccessed | VARCHAR(100) | NULL | System feature accessed |
| PageAccessed | VARCHAR(255) | NULL | Page or screen accessed |
| EntityType | VARCHAR(50) | NULL | Entity type (Supplier, Category, etc.) |
| EntityId | VARCHAR(100) | NULL | Specific entity identifier |
| EntityName | VARCHAR(255) | NULL | Entity display name |
| ActionPerformed | VARCHAR(100) | NOT NULL | Specific action performed |
| DataBefore | TEXT | NULL | Data state before change |
| DataAfter | TEXT | NULL | Data state after change |
| FieldsChanged | TEXT | NULL | Changed fields (JSON array) |
| SearchCriteria | TEXT | NULL | Search criteria used |
| FilterCriteria | TEXT | NULL | Filter criteria applied |
| SortCriteria | TEXT | NULL | Sort criteria used |
| ResultCount | INT | NULL, CHECK >= 0 | Number of results returned |
| RecordsAffected | INT | NULL, CHECK >= 0 | Records affected by action |
| FileDownloaded | VARCHAR(255) | NULL | Downloaded file name |
| FileUploaded | VARCHAR(255) | NULL | Uploaded file name |
| ReportGenerated | VARCHAR(255) | NULL | Generated report name |
| ExportFormat | VARCHAR(20) | NULL | Export file format |
| IPAddress | VARCHAR(45) | NOT NULL | Client IP address |
| UserAgent | VARCHAR(1000) | NULL | Client user agent |
| DeviceType | VARCHAR(50) | NULL | Device type |
| LocationCity | VARCHAR(100) | NULL | Geographic location (city) |
| LocationCountry | VARCHAR(100) | NULL | Geographic location (country) |
| ResponseTime | INT | NULL, CHECK >= 0 | Response time in milliseconds |
| Success | BOOLEAN | NOT NULL, DEFAULT TRUE | Action success flag |
| ErrorCode | VARCHAR(20) | NULL | Error code if applicable |
| ErrorMessage | TEXT | NULL | Error message |
| WarningMessage | TEXT | NULL | Warning message |
| SecurityLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Normal' | Security classification |
| ComplianceRelevant | BOOLEAN | NOT NULL, DEFAULT FALSE | Compliance relevance flag |
| AuditRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Audit requirement flag |
| DataClassification | VARCHAR(20) | NOT NULL, DEFAULT 'Internal' | Data classification level |
| SensitiveData | BOOLEAN | NOT NULL, DEFAULT FALSE | Sensitive data access flag |
| PersonalData | BOOLEAN | NOT NULL, DEFAULT FALSE | Personal data access flag |
| FinancialData | BOOLEAN | NOT NULL, DEFAULT FALSE | Financial data access flag |
| CustomerData | BOOLEAN | NOT NULL, DEFAULT FALSE | Customer data access flag |
| SupplierData | BOOLEAN | NOT NULL, DEFAULT FALSE | Supplier data access flag |
| RiskLevel | VARCHAR(10) | NOT NULL, DEFAULT 'Low' | Activity risk level |
| SuspiciousActivity | BOOLEAN | NOT NULL, DEFAULT FALSE | Suspicious activity indicator |
| PolicyViolation | BOOLEAN | NOT NULL, DEFAULT FALSE | Policy violation flag |
| UnauthorizedAccess | BOOLEAN | NOT NULL, DEFAULT FALSE | Unauthorized access flag |
| DataLeakagePotential | BOOLEAN | NOT NULL, DEFAULT FALSE | Data leakage risk flag |
| ComplianceViolation | BOOLEAN | NOT NULL, DEFAULT FALSE | Compliance violation flag |
| BusinessImpact | VARCHAR(10) | NULL | Business impact level |
| BusinessContext | TEXT | NULL | Business context |
| UserRole | VARCHAR(50) | NULL | User role at time of activity |
| DelegatedAction | BOOLEAN | NOT NULL, DEFAULT FALSE | Delegated action flag |
| DelegatedBy | VARCHAR(50) | FK, NULL | Delegating user |
| ApprovalRequired | BOOLEAN | NOT NULL, DEFAULT FALSE | Approval required flag |
| ApprovalStatus | VARCHAR(20) | NULL | Approval status |
| ApprovedBy | VARCHAR(50) | FK, NULL | Approving user |
| ApprovalTimestamp | TIMESTAMP | NULL | Approval timestamp |
| WorkflowId | BIGINT | FK, NULL | Associated workflow |
| BatchId | VARCHAR(100) | NULL | Batch operation identifier |
| TransactionId | VARCHAR(100) | NULL | Transaction identifier |
| CorrelationId | VARCHAR(100) | NULL | Correlation identifier |
| ParentActivityId | BIGINT | FK, NULL | Parent activity reference |
| ChildActivityCount | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Child activities count |
| SystemGenerated | BOOLEAN | NOT NULL, DEFAULT FALSE | System-generated activity |
| AutomatedAction | BOOLEAN | NOT NULL, DEFAULT FALSE | Automated action flag |
| ScheduledAction | BOOLEAN | NOT NULL, DEFAULT FALSE | Scheduled action flag |
| RetentionPeriod | INT | NULL, CHECK > 0 | Retention period in days |
| ArchivalDate | DATE | NULL | Archival date |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |

### Constraints

```sql
-- Primary Key
ALTER TABLE UserActivityLog ADD CONSTRAINT PK_UserActivityLog PRIMARY KEY (ActivityId);

-- Foreign Keys
ALTER TABLE UserActivityLog ADD CONSTRAINT FK_UserActivityLog_User 
    FOREIGN KEY (UserId) REFERENCES UserProfile(UserId);
ALTER TABLE UserActivityLog ADD CONSTRAINT FK_UserActivityLog_Session 
    FOREIGN KEY (SessionId) REFERENCES UserSession(SessionId);
ALTER TABLE UserActivityLog ADD CONSTRAINT FK_UserActivityLog_DelegatedBy 
    FOREIGN KEY (DelegatedBy) REFERENCES UserProfile(UserId);
ALTER TABLE UserActivityLog ADD CONSTRAINT FK_UserActivityLog_ApprovedBy 
    FOREIGN KEY (ApprovedBy) REFERENCES UserProfile(UserId);
ALTER TABLE UserActivityLog ADD CONSTRAINT FK_UserActivityLog_Workflow 
    FOREIGN KEY (WorkflowId) REFERENCES AssessmentWorkflow(WorkflowId);
ALTER TABLE UserActivityLog ADD CONSTRAINT FK_UserActivityLog_ParentActivity 
    FOREIGN KEY (ParentActivityId) REFERENCES UserActivityLog(ActivityId);

-- Check Constraints
ALTER TABLE UserActivityLog ADD CONSTRAINT CK_UserActivityLog_ActivityType 
    CHECK (ActivityType IN ('Login', 'Logout', 'View', 'Create', 'Update', 'Delete', 'Search', 'Export', 
                           'Import', 'Download', 'Upload', 'Approve', 'Reject', 'Submit', 'Print'));
ALTER TABLE UserActivityLog ADD CONSTRAINT CK_UserActivityLog_ActivityCategory 
    CHECK (ActivityCategory IN ('Authentication', 'Authorization', 'Data Access', 'Data Modification', 
                                'Security', 'Compliance', 'System Administration', 'Business Process'));
ALTER TABLE UserActivityLog ADD CONSTRAINT CK_UserActivityLog_SecurityLevel 
    CHECK (SecurityLevel IN ('Low', 'Normal', 'Elevated', 'High', 'Critical'));
ALTER TABLE UserActivityLog ADD CONSTRAINT CK_UserActivityLog_DataClassification 
    CHECK (DataClassification IN ('Public', 'Internal', 'Confidential', 'Restricted'));
ALTER TABLE UserActivityLog ADD CONSTRAINT CK_UserActivityLog_RiskLevel 
    CHECK (RiskLevel IN ('Low', 'Medium', 'High', 'Critical'));
ALTER TABLE UserActivityLog ADD CONSTRAINT CK_UserActivityLog_BusinessImpact 
    CHECK (BusinessImpact IN ('Low', 'Medium', 'High', 'Critical') OR BusinessImpact IS NULL);
ALTER TABLE UserActivityLog ADD CONSTRAINT CK_UserActivityLog_ApprovalStatus 
    CHECK (ApprovalStatus IN ('Pending', 'Approved', 'Rejected', 'Not Required') OR ApprovalStatus IS NULL);

-- Business Rules
ALTER TABLE UserActivityLog ADD CONSTRAINT CK_UserActivityLog_ApprovalTimestamp 
    CHECK (ApprovalTimestamp IS NULL OR ApprovalTimestamp >= ActivityTimestamp);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_UserActivityLog_UserId ON UserActivityLog(UserId);
CREATE INDEX IX_UserActivityLog_SessionId ON UserActivityLog(SessionId);
CREATE INDEX IX_UserActivityLog_DelegatedBy ON UserActivityLog(DelegatedBy);
CREATE INDEX IX_UserActivityLog_ApprovedBy ON UserActivityLog(ApprovedBy);
CREATE INDEX IX_UserActivityLog_WorkflowId ON UserActivityLog(WorkflowId);
CREATE INDEX IX_UserActivityLog_ParentActivityId ON UserActivityLog(ParentActivityId);

-- Timestamp Indexes (most important for performance)
CREATE INDEX IX_UserActivityLog_ActivityTimestamp ON UserActivityLog(ActivityTimestamp DESC);
CREATE INDEX IX_UserActivityLog_CreatedDate ON UserActivityLog(CreatedDate DESC);

-- Activity Classification Indexes
CREATE INDEX IX_UserActivityLog_ActivityType ON UserActivityLog(ActivityType);
CREATE INDEX IX_UserActivityLog_ActivityCategory ON UserActivityLog(ActivityCategory);
CREATE INDEX IX_UserActivityLog_FeatureAccessed ON UserActivityLog(FeatureAccessed);

-- Security and Compliance Indexes
CREATE INDEX IX_UserActivityLog_SecurityLevel ON UserActivityLog(SecurityLevel);
CREATE INDEX IX_UserActivityLog_RiskLevel ON UserActivityLog(RiskLevel);
CREATE INDEX IX_UserActivityLog_SuspiciousActivity ON UserActivityLog(SuspiciousActivity);
CREATE INDEX IX_UserActivityLog_PolicyViolation ON UserActivityLog(PolicyViolation);
CREATE INDEX IX_UserActivityLog_ComplianceRelevant ON UserActivityLog(ComplianceRelevant);

-- Data Access Indexes
CREATE INDEX IX_UserActivityLog_DataClassification ON UserActivityLog(DataClassification);
CREATE INDEX IX_UserActivityLog_SensitiveData ON UserActivityLog(SensitiveData);
CREATE INDEX IX_UserActivityLog_EntityType ON UserActivityLog(EntityType);
CREATE INDEX IX_UserActivityLog_EntityId ON UserActivityLog(EntityId);

-- Network and Location Indexes
CREATE INDEX IX_UserActivityLog_IPAddress ON UserActivityLog(IPAddress);
CREATE INDEX IX_UserActivityLog_LocationCountry ON UserActivityLog(LocationCountry);

-- Boolean Flag Indexes for Common Filters
CREATE INDEX IX_UserActivityLog_Success ON UserActivityLog(Success);
CREATE INDEX IX_UserActivityLog_SystemGenerated ON UserActivityLog(SystemGenerated);

-- Composite Indexes for Common Queries
CREATE INDEX IX_UserActivityLog_User_Timestamp ON UserActivityLog(UserId, ActivityTimestamp DESC);
CREATE INDEX IX_UserActivityLog_Type_Timestamp ON UserActivityLog(ActivityType, ActivityTimestamp DESC);
CREATE INDEX IX_UserActivityLog_Security_Timestamp ON UserActivityLog(SecurityLevel, ActivityTimestamp DESC);
CREATE INDEX IX_UserActivityLog_Entity_Type_Timestamp ON UserActivityLog(EntityType, ActivityType, ActivityTimestamp DESC);

-- Partitioning by ActivityTimestamp (daily partitions for performance)
-- Implementation depends on database system
```

---

## Business Rules and Calculations

### User Access Validation

```sql
-- Function to validate user access to specific resources
CREATE FUNCTION ValidateUserAccess(
    @UserId VARCHAR(50),
    @ResourceType VARCHAR(50),
    @ResourceId VARCHAR(100),
    @ActionType VARCHAR(50)
)
RETURNS BOOLEAN
AS
BEGIN
    DECLARE @HasAccess BOOLEAN = 0;
    DECLARE @UserRole VARCHAR(50);
    DECLARE @UserStatus VARCHAR(20);
    DECLARE @RolePermissions TEXT;
    
    -- Get user role and status
    SELECT @UserRole = PrimaryRole, @UserStatus = UserStatus
    FROM UserProfile
    WHERE UserId = @UserId;
    
    -- Check if user is active
    IF @UserStatus != 'Active'
        RETURN 0;
    
    -- Get role permissions
    SELECT @RolePermissions = SystemPermissions
    FROM UserRole
    WHERE RoleCode = @UserRole
      AND IsActive = 1;
    
    -- Validate permissions (simplified logic)
    -- In real implementation, this would parse JSON permissions
    IF @RolePermissions IS NOT NULL
        SET @HasAccess = 1;
    
    RETURN @HasAccess;
END;
```

### Session Management

```sql
-- Stored procedure to cleanup expired sessions
CREATE PROCEDURE CleanupExpiredSessions
AS
BEGIN
    -- Mark expired sessions as inactive
    UPDATE UserSession
    SET IsActive = 0,
        LogoutTimestamp = ExpiryTimestamp,
        LogoutReason = 'Timeout',
        TimeoutOccurred = 1
    WHERE IsActive = 1
      AND ExpiryTimestamp < GETDATE();
      
    -- Log session timeouts
    INSERT INTO UserActivityLog (
        UserId, SessionId, ActivityTimestamp, ActivityType, ActivityCategory,
        ActivityDescription, Success, SecurityLevel
    )
    SELECT 
        UserId, SessionId, ExpiryTimestamp, 'Logout', 'Authentication',
        'Session expired due to timeout', 1, 'Normal'
    FROM UserSession
    WHERE TimeoutOccurred = 1
      AND LogoutTimestamp IS NOT NULL
      AND NOT EXISTS (
          SELECT 1 FROM UserActivityLog 
          WHERE UserActivityLog.SessionId = UserSession.SessionId
          AND ActivityType = 'Logout'
          AND ActivityDescription LIKE '%timeout%'
      );
END;
```

### Audit Trail Analysis

```sql
-- Stored procedure to identify suspicious user activity patterns
CREATE PROCEDURE AnalyzeSuspiciousActivity(@UserId VARCHAR(50) = NULL)
AS
BEGIN
    WITH ActivityPatterns AS (
        SELECT 
            UserId,
            COUNT(*) AS TotalActivities,
            COUNT(DISTINCT IPAddress) AS UniqueIPs,
            COUNT(CASE WHEN ActivityTimestamp >= DATEADD(hour, -1, GETDATE()) THEN 1 END) AS RecentHourActivities,
            COUNT(CASE WHEN Success = 0 THEN 1 END) AS FailedAttempts,
            COUNT(CASE WHEN SensitiveData = 1 THEN 1 END) AS SensitiveDataAccess
        FROM UserActivityLog
        WHERE ActivityTimestamp >= DATEADD(day, -7, GETDATE())
          AND (@UserId IS NULL OR UserId = @UserId)
        GROUP BY UserId
    )
    SELECT 
        up.UserId,
        up.FirstName + ' ' + up.LastName AS UserName,
        ap.*,
        CASE 
            WHEN ap.UniqueIPs > 10 THEN 'Multiple Location Access'
            WHEN ap.RecentHourActivities > 100 THEN 'High Activity Volume'
            WHEN ap.FailedAttempts > 20 THEN 'Multiple Failed Attempts'
            WHEN ap.SensitiveDataAccess > 50 THEN 'High Sensitive Data Access'
            ELSE 'Normal'
        END AS SuspicionLevel
    FROM ActivityPatterns ap
    JOIN UserProfile up ON ap.UserId = up.UserId
    WHERE ap.UniqueIPs > 5
       OR ap.RecentHourActivities > 50
       OR ap.FailedAttempts > 10
       OR ap.SensitiveDataAccess > 25
    ORDER BY 
        CASE 
            WHEN ap.UniqueIPs > 10 OR ap.RecentHourActivities > 100 OR ap.FailedAttempts > 20 OR ap.SensitiveDataAccess > 50 THEN 1
            ELSE 2
        END,
        ap.TotalActivities DESC;
END;
```

---

## Data Quality Rules

### User Profile Management
- Email addresses must be unique and valid format
- User roles must be active and appropriate for user's responsibilities
- Manager relationships must not create circular references
- Termination dates must be properly set for inactive users

### Session Management
- Session tokens must be cryptographically secure and unique
- Concurrent session limits must be enforced by role
- Session timeouts must be appropriate for security level
- Suspicious activity must be flagged and investigated

### Activity Logging
- All significant user actions must be logged
- Audit trails must be immutable and tamper-evident
- Sensitive data access must be comprehensively tracked
- Log retention must meet compliance requirements

---

*Document Version*: 1.0  
*Last Updated*: August 21, 2025  
*Next Review*: September 21, 2025  
*Document Owner*: Identity & Access Management Team
