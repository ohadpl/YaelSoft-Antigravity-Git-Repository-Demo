%dw 2.0
output application/java
// Builds the flat LandOwner__c records for ONE registration.

fun safeName(n) = (n default "")[0 to 79] default ""

fun toDateOrNull(d) =
    if (d == null or d == "") null else (d as Date {format: "yyyy-MM-dd"} default (d as Date default null))
---
(vars.owners default []) map ((owner) -> do {
    var bp = (vars.businessPartners default {})[owner.businessPartnerId as String] default {}
    ---
    {
        External_Key__c:     owner.id as String,
        Name:                safeName(bp.buisnesspartnername),
        Idtype__c:           bp.idtype,
        IdNumber__c:         (owner.buisnesspartnerlegalidnumber default bp.buisnesspartnerlegalidnumber),
        Address__c:          bp.buisnesspartneradress,
        Essence__c:          vars.reg.rightType,
        OwnershipPercent__c: owner.ownerspercent,
        // Project__c lookup via external code
        ("Project__r": { Project_Code__c: vars.reg.projectCode }) if (vars.reg.projectCode != null),
        BuildingCode__c:     vars.reg.buildingCode,
        Plot__c:             vars.reg.plot,
        FromDate__c:         toDateOrNull(owner.fromdate),
        ToDate__c:           toDateOrNull(owner.toDate)
    }
})
