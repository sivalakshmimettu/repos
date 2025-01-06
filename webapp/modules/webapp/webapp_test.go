package webapp

import (
    "os"
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

// GetTerraformOptions constructs and returns the terraform.Options for testing
func GetTerraformOptions(environment string) *terraform.Options {
    if environment == "" {
        environment = "dev" // Default to 'dev' if the environment is not provided
    }

    tfvarsFile := "../../environments/" + environment + "/terraform.tfvars"
    return &terraform.Options{
        TerraformDir: "../../modules/webapp", // Path to your Terraform module
        VarFiles:     []string{tfvarsFile},   // Dynamically load the correct tfvars file
    }
}

// InitAndPlanTerraform initializes Terraform, runs a plan, and returns the output
func InitAndPlanTerraform(t *testing.T, terraformOptions *terraform.Options) string {
    terraform.InitAndPlan(t, terraformOptions)
    return terraform.Plan(t, terraformOptions)
}

// ValidateTerraformPlan checks that the Terraform plan contains the specified resource
func ValidateTerraformPlan(t *testing.T, planOutput string, resource string) {
    assert.Contains(t, planOutput, resource, "Expected resource %s in the plan", resource)
}

// TestTerraformWebAppPlan tests the Terraform plan for a web app
func TestTerraformWebAppPlan(t *testing.T) {
    env := os.Getenv("TF_VAR_ENV") // e.g., 'dev', 'stag', 'prod'
    terraformOptions := GetTerraformOptions(env)
    planOutput := InitAndPlanTerraform(t, terraformOptions)
    ValidateTerraformPlan(t, planOutput, "azurerm_app_service")
}

// TestTerraformStorageAccountPlan tests the Terraform plan for an Azure Storage Account
//func TestTerraformStorageAccountPlan(t *testing.T) {
    //env := os.Getenv("TF_VAR_ENV") // e.g., 'dev', 'stag', 'prod'
    //terraformOptions := GetTerraformOptions(env)
    //planOutput := InitAndPlanTerraform(t, terraformOptions)
    //ValidateTerraformPlan(t, planOutput, "azurerm_storage_account")
//}
