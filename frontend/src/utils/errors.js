export function convertValidationErrorsToStringArray(errorObject) {
  const concatenatedErrors = []
  for (const key of Object.keys(errorObject)) {
    const propertyError = errorObject[key].toString();
    concatenatedErrors.push(`${key}:${propertyError}`)
  }

  return concatenatedErrors 
}