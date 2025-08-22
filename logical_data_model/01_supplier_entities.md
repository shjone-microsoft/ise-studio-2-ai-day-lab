# Supplier Entities - Logical Data Model

## Overview
This document defines the logical structure for supplier-related entities, including supplier master data, contact information, and location management.

---

## Entity: Supplier

### Purpose
Central entity representing all suppliers (active, inactive, and potential) in MegaMart's global procurement network.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| SupplierId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| SupplierCode | VARCHAR(20) | UK, NOT NULL | Business identifier for supplier |
| LegalName | VARCHAR(255) | NOT NULL | Official legal name of supplier |
| DBAName | VARCHAR(255) | NULL | "Doing Business As" name |
| ParentSupplierId | BIGINT | FK, NULL | Reference to parent company |
| TaxIdentificationNumber | VARCHAR(50) | NOT NULL | Primary tax ID |
| DUNSNumber | VARCHAR(9) | UK, NULL | Dun & Bradstreet identifier |
| CompanyType | VARCHAR(20) | NOT NULL | Public, Private, Partnership, etc. |
| FoundingDate | DATE | NULL | Company founding date |
| EmployeeCount | INT | NULL, CHECK >= 0 | Total number of employees |
| AnnualRevenue | DECIMAL(19,4) | NULL, CHECK >= 0 | Annual revenue amount |
| RevenueCurrencyCode | VARCHAR(3) | FK, NULL | ISO currency code |
| FinancialRating | VARCHAR(10) | NULL | Credit rating (AAA, AA+, etc.) |
| PrimaryIndustryCode | VARCHAR(10) | FK, NOT NULL | NAICS industry classification |
| SecondaryIndustryCode | VARCHAR(10) | FK, NULL | Secondary industry code |
| BusinessDescription | TEXT | NULL | Detailed business description |
| WebsiteURL | VARCHAR(255) | NULL | Primary website URL |
| RelationshipStatus | VARCHAR(20) | NOT NULL, DEFAULT 'Standard' | Strategic, Preferred, Standard, Inactive |
| SupplierTier | VARCHAR(10) | NULL | Tier 1, Tier 2, Tier 3 classification |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active supplier flag |
| IsMinorityOwned | BOOLEAN | NOT NULL, DEFAULT FALSE | Minority-owned business flag |
| IsWomanOwned | BOOLEAN | NOT NULL, DEFAULT FALSE | Woman-owned business flag |
| IsSmallBusiness | BOOLEAN | NOT NULL, DEFAULT FALSE | Small business flag |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |
| Version | INT | NOT NULL, DEFAULT 1 | Optimistic concurrency version |

### Constraints

```sql
-- Primary Key
ALTER TABLE Supplier ADD CONSTRAINT PK_Supplier PRIMARY KEY (SupplierId);

-- Unique Constraints
ALTER TABLE Supplier ADD CONSTRAINT UK_Supplier_SupplierCode UNIQUE (SupplierCode);
ALTER TABLE Supplier ADD CONSTRAINT UK_Supplier_DUNSNumber UNIQUE (DUNSNumber);

-- Foreign Keys
ALTER TABLE Supplier ADD CONSTRAINT FK_Supplier_ParentSupplier 
    FOREIGN KEY (ParentSupplierId) REFERENCES Supplier(SupplierId);
ALTER TABLE Supplier ADD CONSTRAINT FK_Supplier_RevenueCurrency 
    FOREIGN KEY (RevenueCurrencyCode) REFERENCES Currency(CurrencyCode);
ALTER TABLE Supplier ADD CONSTRAINT FK_Supplier_PrimaryIndustry 
    FOREIGN KEY (PrimaryIndustryCode) REFERENCES IndustryCode(IndustryCode);
ALTER TABLE Supplier ADD CONSTRAINT FK_Supplier_SecondaryIndustry 
    FOREIGN KEY (SecondaryIndustryCode) REFERENCES IndustryCode(IndustryCode);

-- Check Constraints
ALTER TABLE Supplier ADD CONSTRAINT CK_Supplier_CompanyType 
    CHECK (CompanyType IN ('Public', 'Private', 'Partnership', 'Sole Proprietorship', 'Non-Profit', 'Government'));
ALTER TABLE Supplier ADD CONSTRAINT CK_Supplier_RelationshipStatus 
    CHECK (RelationshipStatus IN ('Strategic', 'Preferred', 'Standard', 'Inactive', 'Blacklisted'));
ALTER TABLE Supplier ADD CONSTRAINT CK_Supplier_SupplierTier 
    CHECK (SupplierTier IN ('Tier 1', 'Tier 2', 'Tier 3', 'Development'));

-- Business Rules
ALTER TABLE Supplier ADD CONSTRAINT CK_Supplier_FoundingDate 
    CHECK (FoundingDate <= CURRENT_DATE);
ALTER TABLE Supplier ADD CONSTRAINT CK_Supplier_WebsiteURL 
    CHECK (WebsiteURL LIKE 'http%' OR WebsiteURL IS NULL);
```

### Indexes

```sql
-- Primary Key Index (automatically created)
-- Unique Key Indexes (automatically created)

-- Foreign Key Indexes
CREATE INDEX IX_Supplier_ParentSupplierId ON Supplier(ParentSupplierId);
CREATE INDEX IX_Supplier_RevenueCurrencyCode ON Supplier(RevenueCurrencyCode);
CREATE INDEX IX_Supplier_PrimaryIndustryCode ON Supplier(PrimaryIndustryCode);

-- Search and Filter Indexes
CREATE INDEX IX_Supplier_RelationshipStatus ON Supplier(RelationshipStatus);
CREATE INDEX IX_Supplier_SupplierTier ON Supplier(SupplierTier);
CREATE INDEX IX_Supplier_IsActive ON Supplier(IsActive);
CREATE INDEX IX_Supplier_CreatedDate ON Supplier(CreatedDate);

-- Composite Indexes for Common Queries
CREATE INDEX IX_Supplier_Active_Relationship ON Supplier(IsActive, RelationshipStatus);
CREATE INDEX IX_Supplier_Industry_Revenue ON Supplier(PrimaryIndustryCode, AnnualRevenue DESC);
```

---

## Entity: SupplierContact

### Purpose
Manages contact information for supplier personnel across different roles and functions.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| ContactId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| SupplierId | BIGINT | FK, NOT NULL | Reference to supplier |
| ContactType | VARCHAR(20) | NOT NULL | Primary, Billing, Technical, etc. |
| FirstName | VARCHAR(100) | NOT NULL | Contact first name |
| LastName | VARCHAR(100) | NOT NULL | Contact last name |
| Title | VARCHAR(100) | NULL | Job title or position |
| Department | VARCHAR(100) | NULL | Department or division |
| EmailAddress | VARCHAR(255) | NOT NULL | Primary email address |
| AlternateEmail | VARCHAR(255) | NULL | Alternate email address |
| PhoneNumber | VARCHAR(50) | NULL | Primary phone number |
| MobileNumber | VARCHAR(50) | NULL | Mobile phone number |
| FaxNumber | VARCHAR(50) | NULL | Fax number |
| LanguageCode | VARCHAR(2) | FK, NULL | Preferred language (ISO 639-1) |
| TimeZone | VARCHAR(50) | NULL | Contact's time zone |
| IsPrimary | BOOLEAN | NOT NULL, DEFAULT FALSE | Primary contact flag |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active contact flag |
| LastContactDate | TIMESTAMP | NULL | Last contact interaction date |
| Notes | TEXT | NULL | Additional notes about contact |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE SupplierContact ADD CONSTRAINT PK_SupplierContact PRIMARY KEY (ContactId);

-- Foreign Keys
ALTER TABLE SupplierContact ADD CONSTRAINT FK_SupplierContact_Supplier 
    FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId) ON DELETE CASCADE;
ALTER TABLE SupplierContact ADD CONSTRAINT FK_SupplierContact_Language 
    FOREIGN KEY (LanguageCode) REFERENCES Language(LanguageCode);

-- Check Constraints
ALTER TABLE SupplierContact ADD CONSTRAINT CK_SupplierContact_ContactType 
    CHECK (ContactType IN ('Primary', 'Billing', 'Technical', 'Sales', 'Account Manager', 'Executive', 'Legal', 'Quality'));
ALTER TABLE SupplierContact ADD CONSTRAINT CK_SupplierContact_EmailFormat 
    CHECK (EmailAddress LIKE '%@%.%');
ALTER TABLE SupplierContact ADD CONSTRAINT CK_SupplierContact_AlternateEmailFormat 
    CHECK (AlternateEmail LIKE '%@%.%' OR AlternateEmail IS NULL);

-- Business Rules - Ensure each supplier has at least one primary contact
-- This will be enforced via application logic and stored procedures
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_SupplierContact_SupplierId ON SupplierContact(SupplierId);
CREATE INDEX IX_SupplierContact_LanguageCode ON SupplierContact(LanguageCode);

-- Search Indexes
CREATE INDEX IX_SupplierContact_Email ON SupplierContact(EmailAddress);
CREATE INDEX IX_SupplierContact_Name ON SupplierContact(LastName, FirstName);
CREATE INDEX IX_SupplierContact_ContactType ON SupplierContact(ContactType);
CREATE INDEX IX_SupplierContact_IsPrimary ON SupplierContact(IsPrimary);

-- Composite Indexes
CREATE INDEX IX_SupplierContact_Supplier_Primary ON SupplierContact(SupplierId, IsPrimary);
CREATE INDEX IX_SupplierContact_Active_Type ON SupplierContact(IsActive, ContactType);
```

---

## Entity: SupplierLocation

### Purpose
Manages physical locations for suppliers including headquarters, manufacturing facilities, distribution centers, and service offices.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| LocationId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| SupplierId | BIGINT | FK, NOT NULL | Reference to supplier |
| LocationType | VARCHAR(20) | NOT NULL | Headquarters, Manufacturing, etc. |
| LocationName | VARCHAR(255) | NULL | Facility or location name |
| AddressLine1 | VARCHAR(255) | NOT NULL | Primary address line |
| AddressLine2 | VARCHAR(255) | NULL | Secondary address line |
| City | VARCHAR(100) | NOT NULL | City name |
| StateProvince | VARCHAR(100) | NULL | State or province |
| PostalCode | VARCHAR(20) | NULL | Postal or ZIP code |
| CountryCode | VARCHAR(2) | FK, NOT NULL | ISO country code |
| GeographicRegionId | BIGINT | FK, NULL | Reference to geographic region |
| Latitude | DECIMAL(10,8) | NULL | Latitude coordinate |
| Longitude | DECIMAL(11,8) | NULL | Longitude coordinate |
| TimeZone | VARCHAR(50) | NULL | Location time zone |
| IsHeadquarters | BOOLEAN | NOT NULL, DEFAULT FALSE | Headquarters location flag |
| IsPrimaryShipping | BOOLEAN | NOT NULL, DEFAULT FALSE | Primary shipping location flag |
| IsPrimaryBilling | BOOLEAN | NOT NULL, DEFAULT FALSE | Primary billing location flag |
| IsActive | BOOLEAN | NOT NULL, DEFAULT TRUE | Active location flag |
| OperationalStartDate | DATE | NULL | When location became operational |
| OperationalEndDate | DATE | NULL | When location ceased operations |
| EmployeeCount | INT | NULL, CHECK >= 0 | Number of employees at location |
| FloorSpace | DECIMAL(12,2) | NULL, CHECK >= 0 | Floor space in square feet |
| Capacity | VARCHAR(255) | NULL | Production or storage capacity |
| Certifications | TEXT | NULL | Location-specific certifications |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE SupplierLocation ADD CONSTRAINT PK_SupplierLocation PRIMARY KEY (LocationId);

-- Foreign Keys
ALTER TABLE SupplierLocation ADD CONSTRAINT FK_SupplierLocation_Supplier 
    FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId) ON DELETE CASCADE;
ALTER TABLE SupplierLocation ADD CONSTRAINT FK_SupplierLocation_Country 
    FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode);
ALTER TABLE SupplierLocation ADD CONSTRAINT FK_SupplierLocation_GeographicRegion 
    FOREIGN KEY (GeographicRegionId) REFERENCES GeographicRegion(RegionId);

-- Check Constraints
ALTER TABLE SupplierLocation ADD CONSTRAINT CK_SupplierLocation_LocationType 
    CHECK (LocationType IN ('Headquarters', 'Manufacturing', 'Distribution', 'Warehouse', 'Office', 'R&D', 'Service Center', 'Retail'));
ALTER TABLE SupplierLocation ADD CONSTRAINT CK_SupplierLocation_Coordinates 
    CHECK ((Latitude IS NULL AND Longitude IS NULL) OR (Latitude IS NOT NULL AND Longitude IS NOT NULL));
ALTER TABLE SupplierLocation ADD CONSTRAINT CK_SupplierLocation_LatitudeRange 
    CHECK (Latitude BETWEEN -90 AND 90);
ALTER TABLE SupplierLocation ADD CONSTRAINT CK_SupplierLocation_LongitudeRange 
    CHECK (Longitude BETWEEN -180 AND 180);
ALTER TABLE SupplierLocation ADD CONSTRAINT CK_SupplierLocation_OperationalDates 
    CHECK (OperationalEndDate IS NULL OR OperationalEndDate >= OperationalStartDate);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_SupplierLocation_SupplierId ON SupplierLocation(SupplierId);
CREATE INDEX IX_SupplierLocation_CountryCode ON SupplierLocation(CountryCode);
CREATE INDEX IX_SupplierLocation_GeographicRegionId ON SupplierLocation(GeographicRegionId);

-- Search and Filter Indexes
CREATE INDEX IX_SupplierLocation_LocationType ON SupplierLocation(LocationType);
CREATE INDEX IX_SupplierLocation_IsHeadquarters ON SupplierLocation(IsHeadquarters);
CREATE INDEX IX_SupplierLocation_IsActive ON SupplierLocation(IsActive);
CREATE INDEX IX_SupplierLocation_City ON SupplierLocation(City);

-- Geospatial Indexes (if supported by database)
CREATE SPATIAL INDEX IX_SupplierLocation_Coordinates ON SupplierLocation(Latitude, Longitude);

-- Composite Indexes
CREATE INDEX IX_SupplierLocation_Supplier_Type ON SupplierLocation(SupplierId, LocationType);
CREATE INDEX IX_SupplierLocation_Country_Active ON SupplierLocation(CountryCode, IsActive);
```

---

## Entity: SupplierCertification

### Purpose
Tracks certifications, licenses, and accreditations held by suppliers.

### Attributes

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| CertificationId | BIGINT | PK, NOT NULL, IDENTITY | System-generated unique identifier |
| SupplierId | BIGINT | FK, NOT NULL | Reference to supplier |
| CertificationType | VARCHAR(50) | NOT NULL | ISO, Quality, Environmental, etc. |
| CertificationName | VARCHAR(255) | NOT NULL | Official certification name |
| CertificationNumber | VARCHAR(100) | NULL | Certificate number |
| IssuingOrganization | VARCHAR(255) | NOT NULL | Certifying body |
| IssueDate | DATE | NOT NULL | Certification issue date |
| ExpirationDate | DATE | NULL | Certification expiration date |
| RenewalDate | DATE | NULL | Next renewal date |
| CertificationLevel | VARCHAR(50) | NULL | Level or grade of certification |
| Scope | TEXT | NULL | Scope of certification |
| Status | VARCHAR(20) | NOT NULL, DEFAULT 'Active' | Active, Expired, Suspended, Revoked |
| DocumentURL | VARCHAR(500) | NULL | Link to certificate document |
| VerificationDate | DATE | NULL | Last verification date |
| VerifiedBy | VARCHAR(100) | NULL | Who verified the certification |
| Notes | TEXT | NULL | Additional notes |
| CreatedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |
| CreatedBy | VARCHAR(50) | NOT NULL | User who created record |
| ModifiedDate | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Last modification timestamp |
| ModifiedBy | VARCHAR(50) | NOT NULL | User who last modified record |

### Constraints

```sql
-- Primary Key
ALTER TABLE SupplierCertification ADD CONSTRAINT PK_SupplierCertification PRIMARY KEY (CertificationId);

-- Foreign Keys
ALTER TABLE SupplierCertification ADD CONSTRAINT FK_SupplierCertification_Supplier 
    FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId) ON DELETE CASCADE;

-- Check Constraints
ALTER TABLE SupplierCertification ADD CONSTRAINT CK_SupplierCertification_CertificationType 
    CHECK (CertificationType IN ('ISO 9001', 'ISO 14001', 'ISO 45001', 'OHSAS 18001', 'TS 16949', 
                                  'FDA', 'CE', 'UL', 'FCC', 'RoHS', 'REACH', 'Fair Trade', 
                                  'Organic', 'Halal', 'Kosher', 'Other'));
ALTER TABLE SupplierCertification ADD CONSTRAINT CK_SupplierCertification_Status 
    CHECK (Status IN ('Active', 'Expired', 'Suspended', 'Revoked', 'Pending'));
ALTER TABLE SupplierCertification ADD CONSTRAINT CK_SupplierCertification_Dates 
    CHECK (ExpirationDate IS NULL OR ExpirationDate >= IssueDate);
```

### Indexes

```sql
-- Foreign Key Indexes
CREATE INDEX IX_SupplierCertification_SupplierId ON SupplierCertification(SupplierId);

-- Search and Filter Indexes
CREATE INDEX IX_SupplierCertification_CertificationType ON SupplierCertification(CertificationType);
CREATE INDEX IX_SupplierCertification_Status ON SupplierCertification(Status);
CREATE INDEX IX_SupplierCertification_ExpirationDate ON SupplierCertification(ExpirationDate);
CREATE INDEX IX_SupplierCertification_IssuingOrganization ON SupplierCertification(IssuingOrganization);

-- Composite Indexes
CREATE INDEX IX_SupplierCertification_Supplier_Type ON SupplierCertification(SupplierId, CertificationType);
CREATE INDEX IX_SupplierCertification_Status_Expiration ON SupplierCertification(Status, ExpirationDate);
```

---

## Business Rules and Triggers

### Supplier Entity Rules

1. **Unique Supplier Code**: Supplier codes must be unique across all suppliers
2. **Parent Company Validation**: A supplier cannot be its own parent
3. **Primary Contact Requirement**: Each active supplier must have at least one primary contact
4. **Headquarters Requirement**: Each supplier must have exactly one headquarters location

### Stored Procedures

```sql
-- Procedure to validate supplier hierarchy (prevent circular references)
CREATE PROCEDURE ValidateSupplierHierarchy(@SupplierId BIGINT, @ParentSupplierId BIGINT)
AS
BEGIN
    -- Implementation to check for circular references
    -- Raise error if circular reference detected
END;

-- Procedure to ensure primary contact exists
CREATE PROCEDURE EnsurePrimaryContact(@SupplierId BIGINT)
AS
BEGIN
    -- Implementation to validate primary contact requirement
    -- Create default contact if none exists
END;
```

### Audit Triggers

```sql
-- Trigger to log supplier changes
CREATE TRIGGER TR_Supplier_Audit
ON Supplier
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Implementation to log changes to audit table
END;
```

---

## Data Quality Rules

### Supplier Data Quality
- Legal name must be unique within the same parent company hierarchy
- Tax identification numbers must be unique and valid for the country
- DUNS numbers must be valid 9-digit identifiers
- Revenue amounts must be positive values
- Website URLs must be valid HTTP/HTTPS addresses

### Contact Data Quality
- Email addresses must be valid format and unique within supplier
- Phone numbers should follow international formatting standards
- Each supplier must have at least one active primary contact
- Contact types should not duplicate within the same supplier

### Location Data Quality
- Geographic coordinates must be valid latitude/longitude pairs
- Addresses should be validated against postal service databases
- Each supplier must have exactly one headquarters location
- Operational dates must be logically consistent

---

*Document Version*: 1.0  
*Last Updated*: August 21, 2025  
*Next Review*: September 21, 2025  
*Document Owner*: Data Architecture Team
