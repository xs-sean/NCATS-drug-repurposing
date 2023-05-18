MATCH (:ClinicalTrial {NCTId: 'NCT00000102'})--(intervention:Intervention) 
RETURN intervention.InterventionName


 # case sensitive

#intervention.InterventionName
#"Temozolomide+Placebo"
#"Temozolomide+Metformin"

MATCH (:Intervention {InterventionName: 'Temozolomide'})--(clinicaltrial:ClinicalTrial) # case insensitive
RETURN clinicaltrial.NCTId
#	clinicaltrial.NCTId
#"NCT02843230"
#"NCT04829097"
#"NCT05769660"
#"NCT05739942"
#"NCT05109728"


MATCH (n:ClinicalTrial)-[:has_intervention]->(m:Intervention)
WHERE m.InterventionName CONTAINS 'Temozolomide'
RETURN n.NCTId, m.InterventionName

MATCH (n:ClinicalTrial {NCTId: 'NCT03243851'})-[]-(related)  
RETURN n, related

MATCH (:Condition {Condition: 'glioblastoma'})--(clinicaltrial:ClinicalTrial) 
RETURN clinicaltrial.NCTId
 # case sensitive


MATCH (ClinicalTrial)-[]->(Condition) 
WHERE (Condition.Condition=~"(?i)glioblastoma") 
RETURN ClinicalTrial.NCTId LIMIT 5

MATCH (ClinicalTrial)-[]->(Condition) 
WHERE Condition.Condition=~"(?i)glioblastoma"
RETURN ClinicalTrial.NCTId LIMIT 5




MATCH (Intervention)<-[]-(ClinicalTrial)-[]->(Condition), (ClinicalTrial)-[]->(StudyDesign)
WHERE Condition.Condition=~"(?i)glioblastoma"
RETURN DISTINCT ClinicalTrial.NCTId, ClinicalTrial.StudyType, ClinicalTrial.Phase, Condition.Condition, Intervention.InterventionName, Intervention.InterventionType, ClinicalTrial.OverallStatus, ClinicalTrial.StartDate, ClinicalTrial.CompletionDate,StudyDesign.PrimaryOutcomeMeasure, StudyDesign.DesignInterventionModel, StudyDesign.DesignObservationalModel, StudyDesign.DesignMasking
LIMIT 25

MATCH (Intervention)<-[]-(ClinicalTrial)-[]->(Condition), (ClinicalTrial)-[]->(StudyDesign)
WHERE Condition.Condition=~"(?i)glioblastoma" AND Intervention.InterventionName=~"(?i)temozolomide"
RETURN DISTINCT ClinicalTrial.NCTId, ClinicalTrial.StudyType, ClinicalTrial.Phase, Condition.Condition, Intervention.InterventionName, Intervention.InterventionType, ClinicalTrial.OverallStatus, ClinicalTrial.StartDate, ClinicalTrial.CompletionDate,StudyDesign.PrimaryOutcomeMeasure, StudyDesign.DesignInterventionModel, StudyDesign.DesignObservationalModel, StudyDesign.DesignMasking
LIMIT 25




MATCH (Intervention)<-[]-(ClinicalTrial)-[]->(Condition) 
WHERE Condition.Condition=~"(?i)glioblastoma" AND Intervention.InterventionName=~"(?i)temozolomide"
RETURN ClinicalTrial.NCTId 
LIMIT 25

# extracting diseases, interventions (gard name)
MATCH (Intervention)<-[]-(ClinicalTrial)-[]->(Condition)
WHERE ClinicalTrial.StudyType="Interventional" AND Intervention.InterventionType="Drug" 
RETURN DISTINCT ClinicalTrial.NCTId, ClinicalTrial.StudyType, ClinicalTrial.Phase, Condition.Condition, Intervention.InterventionName, Intervention.InterventionType
#LIMIT 25

MATCH (Intervention)<-[]-(ClinicalTrial)-[]->(Condition), (GARD)-[]->(ClinicalTrial)
WHERE ClinicalTrial.StudyType="Interventional" AND Intervention.InterventionType="Drug" 
RETURN DISTINCT ClinicalTrial.NCTId, ClinicalTrial.StudyType, ClinicalTrial.Phase, Condition.Condition, GARD.GARDName, Intervention.InterventionName, Intervention.InterventionType
LIMIT 25

MATCH (Intervention)<-[]-(ClinicalTrial)-[]->(Condition), (GARD)-[]->(ClinicalTrial)
WHERE ClinicalTrial.NCTId="NCT00000102"
RETURN DISTINCT ClinicalTrial.NCTId, ClinicalTrial.StudyType, ClinicalTrial.Phase, Condition.Condition, GARD.GARDName, Intervention.InterventionName, Intervention.InterventionType
LIMIT 25
