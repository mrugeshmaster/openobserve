<!-- skyramp-pom-catalog: auto-generated -->

## FunctionsPage
- **Import:** `../../pages/functionsPages/functionsPage` (CommonJS: `const FunctionsPage = require(...)`)
- **Iframe:** top-level page
- **Properties:**
  - `addFunctionButton` — selector: `[data-test="function-list-add-function-btn"]`
  - `functionNameTrigger` — selector: `[data-test="add-function-name-input-trigger"]`
  - `functionNameInputField` — selector: `[data-test="add-function-name-input-input"]`
  - `functionEditor` — selector: `[data-test="logs-vrl-function-editor"]`
  - `saveButton` — selector: `[data-test="add-function-save-btn"]`
  - `cancelButton` — selector: `[data-test="add-function-cancel-btn"]`
  - `rowEditButtonSelector` — selector: `[data-test="function-list-edit-function-btn"]`
  - `rowDeleteButtonSelector` — selector: `[data-test="function-list-delete-function-btn"]`
  - `confirmDialogPrimaryBtn` — selector: `[data-test="confirm-dialog"] [data-test="o-dialog-primary-btn"]`
- **Methods:**
  - `createVRLFunction(functionName, vrlCode, org?)` — **wrapping**: clickAddFunctionButton + fillFunctionName + selectVRLType + enterFunctionCode + clickSaveButton; ⏱ timing-aware internally
  - `enterFunctionCode(code)` — sets Monaco editor value via evaluate(); ⏱ timing-aware: waitForTimeout(1000)
  - `fillFunctionName(name)` — clicks trigger, fills input; ⏱ timing-aware
  - `clickSaveButton()` — saves function; ⏱ timing-aware: waitForTimeout(2000)
  - `clickAddFunctionButton(org?)` — clicks add button with auto-recovery; ⏱ timing-aware
  - `getFunctionNameCell(name)` — returns locator for `[data-test="function-list-name-cell-${name}"]`
  - `getRowByName(name)` — walks up from name cell to row by `o2-table-row-*` prefix
  - `expectFunctionInList(functionName)` — asserts `getRowByName(name)` is visible

## LoginPage
- **Import:** `../../pages/generalPages/loginPage` (ES module: `import { LoginPage } from ...`)
- **Iframe:** top-level page
- **Properties:**
  - `userIdInput` — selector: `[data-test="login-user-id-field"]`
  - `passwordInput` — selector: `[data-test="login-password-field"]`
  - `loginButton` — selector: `[data-test="login-sign-in"]`
- **Methods:**
  - `fillLoginForm(email, password)` — fills both fields (takes explicit params, no env-var dependency)
  - `submitLoginForm()` — clicks login button
  - `login()` — full login reading from `process.env.ZO_ROOT_USER_EMAIL` / `ZO_ROOT_USER_PASSWORD`; ⏱ timing-aware; 🌐 network-aware: waitForResponse('/auth/login')
