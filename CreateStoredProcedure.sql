--1 : Obtenir tous les problèmes en cours (tous les produits)
CREATE PROCEDURE dbo.GetAllCurrentProblems
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON Tickets.StatutId = Statuses.Id
    WHERE dbo.Statuses.Name = 'En cours';
END
GO

-- 2 : Obtenir tous les problèmes en cours pour un produit (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductCurrentProblems(@ProductName VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
    WHERE dbo.Statuses.Name = 'En cours'
      AND dbo.ProductNames.Name = @ProductName;
END
GO

-- 3 : Obtenir tous les problèmes en cours pour un produit (une seule version)
CREATE PROCEDURE dbo.GetOneProductVersionCurrentProblems(@ProductName VARCHAR(255), @ProductVersion DECIMAL(10, 1))
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id
    WHERE dbo.Statuses.Name = 'En cours'
      AND dbo.ProductNames.Name = @ProductName
      AND dbo.ProductVersions.Version = @ProductVersion;
END
GO

-- 4 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductRangeEncounteredProblems(@ProductName VARCHAR(255), @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
        LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
    WHERE dbo.Statuses.Name = 'En cours'
      AND dbo.ProductNames.Name = @ProductName
      AND DateCreation BETWEEN @BeginDate AND @EndDate;
END
GO

-- 5 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit (une seule version)
CREATE PROCEDURE dbo.GetOneProductRangeVersionEncounteredProblems(@ProductName VARCHAR(255),
                                                                  @ProductVersion DECIMAL(10, 1),
                                                                  @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id

    WHERE dbo.Statuses.Name = 'En cours'
      AND dbo.ProductNames.Name = @ProductName
      AND dbo.ProductVersions.Version = @ProductVersion
      AND DateCreation BETWEEN @BeginDate AND @EndDate;
END
GO

-- 6 : Obtenir tous les problèmes en cours contenant une liste de mots-clés (tous les produits)
CREATE PROCEDURE dbo.GetAllCurrentProblemsKeywords(@CommaDelimitedKeyword VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id

    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = 'En cours'
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 7 : Obtenir tous les problèmes en cours pour un produit contenant une liste de mots-clés (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductCurrentProblemsKeywords(@ProductName VARCHAR(255), @CommaDelimitedKeyword VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id

    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = 'En cours'
                    AND dbo.ProductNames.Name = @ProductName
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 8 : Obtenir tous les problèmes en cours pour un produit contenant une liste de mots-clés (une seule version)
CREATE PROCEDURE dbo.GetOneProductVersionCurrentProblemsKeywords(@ProductName VARCHAR(255),
                                                                 @ProductVersion DECIMAL(10, 1),
                                                                 @CommaDelimitedKeyword VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    SELECT ticket.Id, ticket.Problem
    FROM dbo.Tickets AS ticket
             LEFT JOIN dbo.Statuses
                       ON ticket.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON ticket.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id


    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = 'En cours'
                    AND dbo.ProductNames.Name = @ProductName
                    AND dbo.ProductVersions.Version = @ProductVersion
                    AND ticket.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 9 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit contenant une liste de mots-clés (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductRangeEncounteredProblemsKeywords(@ProductName VARCHAR(255),
                                                                   @CommaDelimitedKeyword VARCHAR(255),
                                                                   @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id

    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = 'En cours'
                    AND dbo.ProductNames.Name = @ProductName
                    AND DateCreation BETWEEN @BeginDate AND @EndDate
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 10 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit contenant une liste de mots-clés (une seule version)
CREATE PROCEDURE dbo.GetOneProductVersionRangeEncounteredProblemsKeywords(@ProductName VARCHAR(255),
                                                                          @ProductVersion DECIMAL(10, 1),
                                                                          @CommaDelimitedKeyword VARCHAR(255),
                                                                          @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id


    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = 'En cours'
                    AND dbo.ProductNames.Name = @ProductName
                    AND dbo.ProductVersions.Version = @ProductVersion
                    AND DateCreation BETWEEN @BeginDate AND @EndDate
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

--Problèmes résolu
-- 11 : Obtenir tous les problèmes résolus (tous les produits)
CREATE PROCEDURE dbo.GetAllSolvedProblems
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Tickets.Id, Tickets.Problem, tickets.Resolution
    FROM dbo.Tickets
             LEFT JOIN dbo.Statuses
                       ON Tickets.StatutId = Statuses.Id
    WHERE dbo.Statuses.Name = 'Résolu';
END
GO

-- 12 : Obtenir tous les problèmes résolus pour un produit (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductSolvedProblems(@ProductName VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
    WHERE dbo.Statuses.Name = 'Résolu'
      AND dbo.ProductNames.Name = @ProductName;
END
GO

-- 13 : Obtenir tous les problèmes résolus pour un produit (une seule version)
CREATE PROCEDURE dbo.GetOneProductVersionSolvedProblems(@ProductName VARCHAR(255), @ProductVersion DECIMAL(10, 1))
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id
    WHERE dbo.Statuses.Name = 'Résolu'
      AND dbo.ProductNames.Name = @ProductName
      AND dbo.ProductVersions.Version = @ProductVersion;
END
GO

-- 14 : Obtenir tous les problèmes résolus au cours d’une période donnée pour un produit (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductRangeSolvedProblems(@ProductName VARCHAR(255), @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
    WHERE dbo.Statuses.Name = 'Résolu'
      AND dbo.ProductNames.Name = @ProductName
      AND DateCreation BETWEEN @BeginDate AND @EndDate;
END
GO

-- 15 : Obtenir tous les problèmes résolus au cours d’une période donnée pour un produit (une seule version)
CREATE PROCEDURE dbo.GetOneProductRangeVersionSolvedProblems(@ProductName VARCHAR(255), @ProductVersion DECIMAL(10, 1),
                                                             @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id

    WHERE dbo.Statuses.Name = 'Résolu'
      AND dbo.ProductNames.Name = @ProductName
      AND dbo.ProductVersions.Version = @ProductVersion
      AND DateCreation BETWEEN @BeginDate AND @EndDate;
END
GO

-- 16 : Obtenir tous les problèmes résolus contenant une liste de mots-clés (tous les produits)
CREATE PROCEDURE dbo.GetAllSolvedProblemsKeywords(@CommaDelimitedKeyword VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id

    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = 'Résolu'
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 17 : Obtenir tous les problèmes résolus pour un produit contenant une liste de mots-clés (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductSolvedProblemsKeywords(@ProductName VARCHAR(255), @CommaDelimitedKeyword VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id

    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = 'Résolu'
                    AND dbo.ProductNames.Name = @ProductName
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 18 : Obtenir tous les problèmes résolus pour un produit contenant une liste de mots-clés (une seule version)
CREATE PROCEDURE dbo.GetOneProductVersionSolvedProblemsKeywords(@ProductName VARCHAR(255),
                                                                @ProductVersion DECIMAL(10, 1),
                                                                @CommaDelimitedKeyword VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id


    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = 'Résolu'
                    AND dbo.ProductNames.Name = @ProductName
                    AND dbo.ProductVersions.Version = @ProductVersion
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 19 : Obtenir tous les problèmes résolus au cours d’une période donnée pour un produit contenant une liste de mots-clés (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductRangeSolvedProblemsKeywords(@ProductName VARCHAR(255),
                                                              @CommaDelimitedKeyword VARCHAR(255),
                                                              @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id

    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = 'Résolu'
                    AND dbo.ProductNames.Name = @ProductName
                    AND DateCreation BETWEEN @BeginDate AND @EndDate
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 20 : Obtenir tous les problèmes résolus au cours d’une période donnée pour un produit contenant une liste de mots-clés (une seule version)
CREATE PROCEDURE dbo.GetOneProductVersionRangeSolvedProblemsKeywords(@ProductName VARCHAR(255),
                                                                     @ProductVersion DECIMAL(10, 1),
                                                                     @CommaDelimitedKeyword VARCHAR(255),
                                                                     @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id


    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = 'Résolu'
                    AND dbo.ProductNames.Name = @ProductName
                    AND dbo.ProductVersions.Version = @ProductVersion
                    AND DateCreation BETWEEN @BeginDate AND @EndDate
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO
