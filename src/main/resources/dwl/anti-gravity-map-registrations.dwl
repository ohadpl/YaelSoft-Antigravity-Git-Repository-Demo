%dw 2.0
output application/java
// Input: vars.allRegistrations = accumulated OData registrations
// Projects each registration record to the slim shape used by the batch.
---
(vars.allRegistrations default []) map ((reg) -> {
    registrationKey: reg.registrationKey,
    buildingCode:    reg.buildingCode,
    propertyKey:     reg.propertyKey,
    projectCode:     reg.project_code,
    rightType:       reg.righttype,
    plot:            reg.plot
})
