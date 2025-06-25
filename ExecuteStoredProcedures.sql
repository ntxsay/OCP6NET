-- Problèmes
EXEC GetAllCurrentProblems;
EXEC GetOneProductCurrentProblems 'Trader en Herbe';
EXEC GetOneProductVersionCurrentProblems 'Trader en Herbe', 1.1;
EXEC GetOneProductRangeEncounteredProblems 'Trader en Herbe', '20211021', '20230401';
EXEC GetOneProductRangeVersionEncounteredProblems 'Trader en Herbe', 1.2, '20211021', '20230401';
EXEC GetAllCurrentProblemsKeywords 'bourse,trading';
EXEC GetOneProductCurrentProblemsKeywords 'Trader en Herbe', 'bourse,trading';
EXEC GetOneProductVersionCurrentProblemsKeywords 'Trader en Herbe', 1.2, 'bourse,trading';
EXEC GetOneProductRangeEncounteredProblemsKeywords 'Trader en Herbe', 'bourse,trading', '20211021', '20230401';
EXEC GetOneProductVersionRangeEncounteredProblemsKeywords 'Trader en Herbe', 1.2, 'bourse,trading', '20211021',
     '20230401';

--Résolu
EXEC GetAllSolvedProblems;
EXEC GetOneProductSolvedProblems 'Planificateur d''Entraînement';
EXEC GetOneProductVersionSolvedProblems 'Planificateur d''Entraînement', 1.1;
EXEC GetOneProductRangeSolvedProblems 'Planificateur d''Entraînement', '20201202', '20211201';
EXEC GetOneProductRangeVersionSolvedProblems 'Planificateur d''Entraînement', 1.1, '20201202', '20211201';
EXEC GetAllSolvedProblemsKeywords 'erreur, gps, statistiques';
EXEC GetOneProductSolvedProblemsKeywords 'Planificateur d''Entraînement', 'erreur, gps, statistiques';
EXEC GetOneProductVersionSolvedProblemsKeywords 'Planificateur d''Entraînement', 1.1, 'erreur, gps, statistiques';
EXEC GetOneProductRangeSolvedProblemsKeywords 'Planificateur d''Entraînement', 'erreur, gps, statistiques', '20201202',
     '20211201';
EXEC GetOneProductVersionRangeSolvedProblemsKeywords 'Planificateur d''Entraînement', 1.1, 'erreur, gps, statistiques',
     '20201202',
     '20211201';