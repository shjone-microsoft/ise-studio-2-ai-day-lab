Feature: Electronics Category Manager Supplier Management
  As Marcus Rodriguez, Category Manager for Electronics & Technology
  I want to efficiently manage my electronics supplier portfolio and reduce China dependency
  So that I can maintain profitability while mitigating tariff risks

  Background:
    Given I am logged in as Marcus Rodriguez, Category Manager for Electronics
    And I have access to the supplier management system
    And I manage $8B annual electronics sourcing across 500+ suppliers globally

  @critical @supplier-diversification
  Scenario: Urgent supplier diversification due to tariff increase
    Given a major supplier announces a 20% price increase due to new tariffs
    And this supplier represents 15% of my electronics category spend
    When I request alternative suppliers for the affected products
    Then the system should provide a ranked list of alternative suppliers within 24 hours
    And each alternative should include capability match score
    And each alternative should include risk assessment score
    And each alternative should include pricing estimates
    And the alternatives should be geographically diversified outside China

  @product-sourcing @innovation
  Scenario: Sourcing innovative smart home device for private label
    Given I need to source a new smart home device for private label development
    And the device requires IoT connectivity and AI capabilities
    When I search for suppliers with specific technology capabilities
    Then the system should suggest suppliers based on technology capabilities
    And the suppliers should have innovation track record in smart home devices
    And the suppliers should have appropriate risk profile for private label partnership
    And I should be able to filter by geographic region and production capacity

  @quality-crisis @backup-suppliers
  Scenario: Quality crisis requires immediate supplier switch
    Given quality issues are discovered with a key smartphone accessory supplier
    And this supplier provides 25% of our smartphone accessories
    When a quality crisis is declared for this supplier
    Then the system should immediately present pre-qualified backup suppliers
    And the backup suppliers should have current risk assessments
    And the backup suppliers should have verified quality certifications
    And I should see estimated lead times for production transfer
    And I should receive automated notifications to relevant stakeholders

  @regional-analysis @risk-assessment
  Scenario: Analyze China dependency across electronics portfolio
    Given I want to reduce China dependency from 70% to 40% within 18 months
    When I request a China dependency analysis for my electronics portfolio
    Then the system should show current China spend percentage by subcategory
    And I should see risk scores for each China-based supplier
    And I should see recommended alternative suppliers by subcategory
    And I should get a diversification timeline with milestones
    And I should be able to export the analysis for stakeholder reporting

  @supplier-comparison @decision-support
  Scenario: Compare suppliers for new product category entry
    Given I am expanding into wearable technology products
    And I need to evaluate potential suppliers for fitness trackers
    When I request supplier comparisons for wearable technology
    Then I should see suppliers ranked by multiple criteria including:
      | Criteria               | Weight |
      | Technology capability  | 30%    |
      | Quality track record   | 25%    |
      | Cost competitiveness   | 20%    |
      | Geographic location    | 15%    |
      | Production capacity    | 10%    |
    And I should be able to adjust the weighting criteria
    And I should see detailed capability assessments for each supplier

  @mobile-alerts @real-time-monitoring
  Scenario: Receive mobile alerts for critical supplier issues
    Given I have configured mobile alerts for critical supplier issues
    And I am traveling to a trade show in Las Vegas
    When a critical risk alert is triggered for a key supplier
    Then I should receive a mobile push notification within 15 minutes
    And the alert should include supplier name and risk category
    And I should be able to view full risk details from my mobile device
    And I should be able to initiate contingency plans from the mobile interface

  @integration @workflow
  Scenario: Integrate supplier data with PLM system for new product development
    Given I am working on new product specifications in the PLM system
    And the product requires specific component capabilities
    When I request supplier suggestions based on PLM product specifications
    Then the system should automatically match suppliers to component requirements
    And supplier suggestions should appear directly in the PLM workflow
    And I should see supplier capability ratings for each specification requirement
    And I should be able to initiate supplier contact directly from PLM

  @performance-tracking @kpi-management
  Scenario: Track supplier diversification progress against KPI targets
    Given my KPI target is maximum 30% spend with any single supplier
    And my goal is to reduce China dependency to 40% within 18 months
    When I access my supplier diversification dashboard
    Then I should see current concentration percentages by supplier
    And I should see China dependency percentage with trend analysis
    And I should see progress indicators toward my diversification targets
    And I should receive recommendations for next priority diversification actions
    And I should be able to schedule automated monthly progress reports

  @competitive-intelligence @market-analysis
  Scenario: Track competitor sourcing strategies and supplier moves
    Given I want to stay informed about competitor sourcing strategies
    When I access competitive intelligence features
    Then I should see alerts about competitors switching suppliers
    And I should see market intelligence about new supplier capabilities
    And I should see industry trends in supplier diversification
    And I should be able to benchmark my supplier portfolio against industry standards
