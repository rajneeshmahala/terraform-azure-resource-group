#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -euo pipefail

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Directory paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXAMPLE_DIR="${SCRIPT_DIR}/example"

# Help message
show_help() {
  echo -e "Terraform Module Runner Script"
  echo -e "Usage: $0 [command]"
  echo -e ""
  echo -e "Commands:"
  echo -e "  init       Initialize Terraform in the example directory"
  echo -e "  validate   Format check and validate the Terraform configuration"
  echo -e "  plan       Generate and show an execution plan"
  echo -e "  apply      Builds or changes infrastructure"
  echo -e "  destroy    Destroy Terraform-managed infrastructure"
  echo -e "  help       Show this help message"
  echo -e ""
}

# Run command based on argument
COMMAND="${1:-plan}"

case "${COMMAND}" in
  init)
    echo -e "${YELLOW}Initializing Terraform in ${EXAMPLE_DIR}...${NC}"
    terraform -chdir="${EXAMPLE_DIR}" init
    echo -e "${GREEN}Terraform initialized successfully!${NC}"
    ;;
  validate)
    echo -e "${YELLOW}Formatting files...${NC}"
    terraform -chdir="${SCRIPT_DIR}" fmt
    terraform -chdir="${EXAMPLE_DIR}" fmt
    
    echo -e "${YELLOW}Validating configuration in ${EXAMPLE_DIR}...${NC}"
    terraform -chdir="${EXAMPLE_DIR}" validate
    echo -e "${GREEN}Configuration is valid!${NC}"
    ;;
  plan)
    echo -e "${YELLOW}Running Terraform validation...${NC}"
    terraform -chdir="${EXAMPLE_DIR}" validate
    
    echo -e "${YELLOW}Generating Terraform execution plan...${NC}"
    terraform -chdir="${EXAMPLE_DIR}" plan -out=tfplan
    echo -e "${GREEN}Plan generated and saved to tfplan in ${EXAMPLE_DIR}.${NC}"
    ;;
  apply)
    if [ ! -f "${EXAMPLE_DIR}/tfplan" ]; then
      echo -e "${YELLOW}No execution plan (tfplan) found. Running plan first...${NC}"
      terraform -chdir="${EXAMPLE_DIR}" plan -out=tfplan
    fi
    echo -e "${YELLOW}Applying plan...${NC}"
    terraform -chdir="${EXAMPLE_DIR}" apply tfplan
    echo -e "${GREEN}Apply completed!${NC}"
    # Clean up plan file after successful apply
    rm -f "${EXAMPLE_DIR}/tfplan"
    ;;
  destroy)
    echo -e "${RED}WARNING: You are about to destroy infrastructure!${NC}"
    read -p "Are you sure you want to proceed? (y/N) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      terraform -chdir="${EXAMPLE_DIR}" destroy
      echo -e "${GREEN}Infrastructure destroyed!${NC}"
    else
      echo -e "${YELLOW}Destroy cancelled.${NC}"
    fi
    ;;
  help|-h|--help)
    show_help
    ;;
  *)
    echo -e "${RED}Error: Unknown command '${COMMAND}'${NC}\n"
    show_help
    exit 1
    ;;
esac
