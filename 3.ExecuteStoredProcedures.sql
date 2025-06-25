--CURRENT PROBLEMS
-- 1 : Obtenir tous les problèmes résolus ou non (tous les produits)
EXEC GetAllProblems 0;
-- 2 : Obtenir tous les problèmes résolus ou non pour un produit (toutes les versions)
EXEC GetOneProductProblems 0, 'Trader en Herbe';
-- 3 : Obtenir tous les problèmes résolus ou non pour un produit (une seule version)
EXEC GetOneProductVersionProblems 0, 'Trader en Herbe', 1.1;
-- 4 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit (toutes les versions)
EXEC GetOneProductDateRangeProblems 0, 'Trader en Herbe', '20211021', '20230401';
-- 5 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit (une seule version)
EXEC GetOneProductVersionDateRangeProblems 0, 'Trader en Herbe', 1.2, '20211021', '20230401';
-- 6 : Obtenir tous les problèmes résolus ou non contenant une liste de mots-clés (tous les produits)
EXEC GetAllProblemsKeywords 0, 'bourse,trading';
-- 7 : Obtenir tous les problèmes résolus ou non pour un produit contenant une liste de mots-clés (toutes les versions)
EXEC GetOneProductProblemsKeywords 0, 'Trader en Herbe', 'bourse,trading';
-- 8 : Obtenir tous les problèmes résolus ou non pour un produit contenant une liste de mots-clés (une seule version)
EXEC GetOneProductVersionProblemsKeywords 0, 'Trader en Herbe', 1.2, 'bourse,trading';
-- 9 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit contenant une liste de mots-clés (toutes les versions)
EXEC GetOneProductDateRangeProblemsKeywords 0, 'Trader en Herbe', 'bourse,trading', '20211021', '20230401';
-- 10 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit contenant une liste de mots-clés (une seule version)
EXEC GetOneProductVersionDateRangeProblemsKeywords 0, 'Trader en Herbe', 1.2, 'bourse,trading', '20211021',
     '20230401';
-- RESOLVED
-- 11 : Obtenir tous les problèmes résolus (tous les produits)
EXEC GetAllProblems 1;
-- 12 : Obtenir tous les problèmes résolus pour un produit (toutes les versions)
EXEC GetOneProductProblems 1, 'Planificateur d''Entraînement';
-- 13 : Obtenir tous les problèmes résolus pour un produit (une seule version)
EXEC GetOneProductVersionProblems 1, 'Planificateur d''Entraînement', 1.1;
-- 14 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit (toutes les versions)
EXEC GetOneProductDateRangeProblems 1, 'Planificateur d''Entraînement', '20201202', '20211201';
-- 15 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit (une seule version)
EXEC GetOneProductVersionDateRangeProblems 1, 'Planificateur d''Entraînement', 1.1, '20201202', '20211201';
-- 16 : Obtenir tous les problèmes résolus contenant une liste de mots-clés (tous les produits)
EXEC GetAllProblemsKeywords 1, 'erreur, gps, statistiques';
-- 17 : Obtenir tous les problèmes résolus pour un produit contenant une liste de mots-clés (toutes les versions)
EXEC GetOneProductProblemsKeywords 1, 'Planificateur d''Entraînement', 'erreur, gps, statistiques';
-- 18 : Obtenir tous les problèmes résolus pour un produit contenant une liste de mots-clés (une seule version)
EXEC GetOneProductVersionProblemsKeywords 1, 'Planificateur d''Entraînement', 1.1, 'erreur, gps, statistiques';
-- 19 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit contenant une liste de mots-clés (toutes les versions)
EXEC GetOneProductDateRangeProblemsKeywords 1, 'Planificateur d''Entraînement', 'erreur, gps, statistiques',
     '20201202', '20211201';
-- 20 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit contenant une liste de mots-clés (une seule version)
EXEC GetOneProductVersionDateRangeProblemsKeywords 1, 'Planificateur d''Entraînement', 1.1,
     'erreur, gps, statistiques', '20201202', '20211201';
