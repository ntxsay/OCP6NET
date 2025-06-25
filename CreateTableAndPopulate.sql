Use
NexaWorksTicketsDb;
GO

/*
 * Création des tables
 */

IF OBJECT_ID('dbo.ProductNames', 'U') IS NOT NULL
DROP TABLE ProductNames;
GO

CREATE TABLE ProductNames
(
    Id   INT PRIMARY KEY IDENTITY,
    Name VARCHAR(255) NOT NULL
);
GO

IF OBJECT_ID('dbo.ProductVersions', 'U') IS NOT NULL
DROP TABLE ProductVersions;
GO

CREATE TABLE ProductVersions
(
    Id      INT PRIMARY KEY IDENTITY,
    Version DECIMAL(10, 1) NOT NULL
);
GO

IF OBJECT_ID('dbo.OperatingSystems', 'U') IS NOT NULL
DROP TABLE OperatingSystems;
GO

CREATE TABLE OperatingSystems
(
    Id     INT PRIMARY KEY IDENTITY,
    OsName VARCHAR(255) NOT NULL
);
GO

IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL
DROP TABLE Products;
GO

CREATE TABLE Products
(
    Id                INT PRIMARY KEY IDENTITY,
    ProductNameId     INT NOT NULL REFERENCES dbo.ProductNames (Id) ON DELETE CASCADE,
    ProductVersionId  INT NOT NULL REFERENCES dbo.ProductVersions (Id) ON DELETE CASCADE,
    OperatingSystemId INT NOT NULL REFERENCES dbo.OperatingSystems (Id) ON DELETE CASCADE,
);
GO

IF OBJECT_ID('dbo.Statuses', 'U') IS NOT NULL
DROP TABLE Statuses;
GO

CREATE TABLE Statuses
(
    Id          INT PRIMARY KEY IDENTITY,
    Name        VARCHAR(255) NOT NULL,
    Description VARChAR(1000) NULL
);
GO

IF OBJECT_ID('dbo.Tickets', 'U') IS NOT NULL
DROP TABLE Tickets;
GO

CREATE TABLE Tickets
(
    Id             INT PRIMARY KEY IDENTITY,
    ProductId      INTEGER  NOT NULL REFERENCES dbo.Products (Id) ON DELETE CASCADE,
    StatutId       INTEGER  NOT NULL REFERENCES dbo.Statuses (Id) ON DELETE CASCADE,
    DateCreation   DATETIME NOT NULL DEFAULT (GETDATE()),
    DateResolution DATETIME NULL,
    Problem        VARCHAR(MAX
) NOT NULL,
    Resolution     VARCHAR(MAX) NULL
);
GO

/*
 * Déclaration des noms de produits
 */

DECLARE
@traderEnHerbeName AS VARCHAR(255) = 'Trader en Herbe';
DECLARE
@maitreInvestissementName AS VARCHAR(255) = 'Maître des Investissements';
DECLARE
@planificateurEntrainementName AS VARCHAR(255) = 'Planificateur d''Entraînement';
DECLARE
@planificateurAnxieteName AS VARCHAR(255) = 'Planificateur d''Anxiété Sociale';

/*
 * Déclaration des noms de systèmes d'exploitation
 */
        
DECLARE
@androidName AS VARCHAR(255) = 'Android';
DECLARE
@windowsName AS VARCHAR(255) = 'Windows';
DECLARE
@iOsName AS VARCHAR(255) = 'iOS';
DECLARE
@macOsName AS VARCHAR(255) = 'macOS';
DECLARE
@linuxName AS VARCHAR(255) = 'Linux';
DECLARE
@windowsMobileName AS VARCHAR(255) = 'Windows Mobile';


/*
 * Déclaration des noms de status
 */
DECLARE
@resoluStatusName AS VARCHAR(255) = 'Résolu';
DECLARE
@enCoursStatusName AS VARCHAR(255) = 'En cours';

/*
 * Insertion des données dans les tables de bases
 */

INSERT INTO dbo.ProductNames(Name)
VALUES (@traderEnHerbeName),
       (@maitreInvestissementName),
       (@planificateurEntrainementName),
       (@planificateurAnxieteName);

INSERT INTO dbo.ProductVersions(Version)
VALUES (1.0),
       (1.1),
       (1.2),
       (1.3),
       (2.0),
       (2.1);

INSERT INTO dbo.OperatingSystems(OsName)
VALUES (@androidName),
       (@iOsName),
       (@windowsName),
       (@macOsName),
       (@linuxName),
       (@windowsMobileName);



INSERT INTO dbo.Statuses(Name, Description)
VALUES (@resoluStatusName, NULL),
       (@enCoursStatusName, NULL);

/*
 * Déclaration de variables par faciliter l'insertion de données contenant des cléfs étrangères
 */

DECLARE
@traderEnHerbeId AS INT, @maitreInvestissementId AS INT, @planificateurEntrainementId AS INT , @planificateurAnxieteId AS INT;
SELECT @traderEnHerbeId = Id
FROM dbo.ProductNames
WHERE Name = @traderEnHerbeName;
SELECT @maitreInvestissementId = Id
FROM dbo.ProductNames
WHERE Name = @maitreInvestissementName;
SELECT @planificateurEntrainementId = Id
FROM dbo.ProductNames
WHERE Name = @planificateurEntrainementName;
SELECT @planificateurAnxieteId = Id
FROM dbo.ProductNames
WHERE Name = @planificateurAnxieteName;

DECLARE
@version1_0Id AS INT, @version1_1Id AS INT, @version1_2Id AS INT, @version1_3Id AS INT, @version2_0Id AS INT, @version2_1Id AS INT;
SELECT @version1_0Id = Id
FROM dbo.ProductVersions
WHERE Version = 1.0;
SELECT @version1_1Id = Id
FROM dbo.ProductVersions
WHERE Version = 1.1;
SELECT @version1_2Id = Id
FROM dbo.ProductVersions
WHERE Version = 1.2;
SELECT @version1_3Id = Id
FROM dbo.ProductVersions
WHERE Version = 1.3;
SELECT @version2_0Id = Id
FROM dbo.ProductVersions
WHERE Version = 2.0;
SELECT @version2_1Id = Id
FROM dbo.ProductVersions
WHERE Version = 2.1;

DECLARE
@windowsId AS INT, @androidId AS INT, @iOsId AS INT, @macOsId AS INT, @linuxId AS INT, @windowsMobileId AS INT;
SELECT @androidId = Id
FROM dbo.OperatingSystems
WHERE OsName = @androidName;
SELECT @windowsId = Id
FROM dbo.OperatingSystems
WHERE OsName = @windowsName;
SELECT @iOsId = Id
FROM dbo.OperatingSystems
WHERE OsName = @iOsName;
SELECT @macOsId = Id
FROM dbo.OperatingSystems
WHERE OsName = @macOsName;
SELECT @linuxId = Id
FROM dbo.OperatingSystems
WHERE OsName = @linuxName;
SELECT @windowsMobileId = Id
FROM dbo.OperatingSystems
WHERE OsName = @windowsMobileName;


/*
 * Déclaration de variables par faciliter l'insertion de données contenant des cléfs étrangères
 */

INSERT INTO dbo.Products(ProductNameId, ProductVersionId, OperatingSystemId)
VALUES
    ---- Trader en Herbe
    --Linux
    (@traderEnHerbeId, @version1_0Id, @linuxId),
    (@traderEnHerbeId, @version1_1Id, @linuxId),
    (@traderEnHerbeId, @version1_2Id, @linuxId),
    -- macOS
    (@traderEnHerbeId, @version1_1Id, @macOsId),
    (@traderEnHerbeId, @version1_2Id, @macOsId),
    (@traderEnHerbeId, @version1_3Id, @macOsId),
    -- windows
    (@traderEnHerbeId, @version1_0Id, @windowsId),
    (@traderEnHerbeId, @version1_1Id, @windowsId),
    (@traderEnHerbeId, @version1_2Id, @windowsId),
    (@traderEnHerbeId, @version1_3Id, @windowsId),
    -- android
    (@traderEnHerbeId, @version1_2Id, @androidId),
    (@traderEnHerbeId, @version1_3Id, @androidId),
    -- iOS
    (@traderEnHerbeId, @version1_2Id, @iOsId),
    (@traderEnHerbeId, @version1_3Id, @iOsId),
    -- windows mobile
    (@traderEnHerbeId, @version1_2Id, @windowsMobileId),

    ---- Maître des Investissements
    --macOS
    (@maitreInvestissementId, @version1_0Id, @macOsId),
    (@maitreInvestissementId, @version2_0Id, @macOsId),
    (@maitreInvestissementId, @version2_1Id, @macOsId),
    -- windows
    (@maitreInvestissementId, @version2_1Id, @windowsId),
    -- android
    (@maitreInvestissementId, @version2_0Id, @androidId),
    (@maitreInvestissementId, @version2_1Id, @androidId),
    -- ios
    (@maitreInvestissementId, @version2_0Id, @iOsId),
    (@maitreInvestissementId, @version2_1Id, @iOsId),

    ---- Planificateur d'Entraînement
    -- linux
    (@planificateurEntrainementId, @version1_0Id, @linuxId),
    (@planificateurEntrainementId, @version1_1Id, @linuxId),
    --macos
    (@planificateurEntrainementId, @version1_0Id, @macOsId),
    (@planificateurEntrainementId, @version1_1Id, @macOsId),
    (@planificateurEntrainementId, @version2_0Id, @macOsId),
    --windows
    (@planificateurEntrainementId, @version1_1Id, @windowsId),
    (@planificateurEntrainementId, @version2_0Id, @windowsId),
    --android
    (@planificateurEntrainementId, @version1_1Id, @androidId),
    (@planificateurEntrainementId, @version2_0Id, @androidId),
    --iOs
    (@planificateurEntrainementId, @version1_1Id, @iOsId),
    (@planificateurEntrainementId, @version2_0Id, @iOsId),
    --windows mobile
    (@planificateurEntrainementId, @version1_1Id, @windowsMobileId),

    ---- Planificateur d'Anxiété Sociale
    -- macOS
    (@planificateurAnxieteId, @version1_0Id, @macOsId),
    (@planificateurAnxieteId, @version1_1Id, @macOsId),
    -- windows
    (@planificateurAnxieteId, @version1_0Id, @windowsId),
    (@planificateurAnxieteId, @version1_1Id, @windowsId),
    -- android
    (@planificateurAnxieteId, @version1_0Id, @androidId),
    (@planificateurAnxieteId, @version1_1Id, @androidId),
    -- ios
    (@planificateurAnxieteId, @version1_0Id, @iOsId),
    (@planificateurAnxieteId, @version1_1Id, @iOsId);

/*
 * Déclaration de variables par faciliter l'insertion de tickets
 */

DECLARE
@resoluStatusId AS INT, @enCoursStatusId AS INT;
SELECT @resoluStatusId = Id
FROM dbo.Statuses
WHERE Name = @resoluStatusName;
SELECT @enCoursStatusId = Id
FROM dbo.Statuses
WHERE Name = @enCoursStatusName;

/**
  * Insertion des tickets
 */

-- Ticket 1
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @traderEnHerbeId
           AND ProductVersionId = @version1_3Id
           AND OperatingSystemId = @windowsId),
        @resoluStatusId,
        '20230426 13:23:44',
        '20230510 05:23:44',
        'Crash sur Windows lors de l''ouverture de la fenêtre de trading avec plusieurs écrans.',
        'Bug causé par une mauvaise gestion des DPI par écran. Correction en forçant un repositionnement par défaut sur l''écran principal via Screen.PrimaryScreen.WorkingArea.');

-- Ticket 2
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @traderEnHerbeId
           AND ProductVersionId = @version1_1Id
           AND OperatingSystemId = @linuxId),
        @enCoursStatusId,
        '20211021 00:00:00',
        NULL,
        'Sur les distributions Fedora, les données boursières ne chargent pas.',
        NULL);

-- Ticket 3
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @traderEnHerbeId
           AND ProductVersionId = @version1_2Id
           AND OperatingSystemId = @androidId),
        @enCoursStatusId,
        '20221021 00:00:00',
        NULL,
        'Les ordres de bourse sont impossible à placer car le champ se désactive après remplissage auto.',
        NULL);

-- Ticket 4
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @traderEnHerbeId
           AND ProductVersionId = @version1_2Id
           AND OperatingSystemId = @iOsId),
        @resoluStatusId,
        '20220321 00:00:00',
        '20220515 00:00:00',
        'le graphique de trading ne se met plus à jour après une mise en veille.',
        'Résolu en ajoutant un viewWillAppear() forcé qui recharge les données si le temps passé inactif > 60 sec.');

-- Ticket 5
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @traderEnHerbeId
           AND ProductVersionId = @version1_3Id
           AND OperatingSystemId = @macOsId),
        @enCoursStatusId,
        '20230415 00:00:00',
        NULL,
        'L''authentification par Face ID / Touch ID ne fonctionne pas après la mise à jour vers la dernière version de macOS.',
        NULL);

-- Ticket 6
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @traderEnHerbeId
           AND ProductVersionId = @version1_2Id
           AND OperatingSystemId = @windowsMobileId),
        @resoluStatusId,
        '20230415 00:00:00',
        '20230512 00:00:00',
        'Erreur SSL sur la page de connexion.',
        'La bibliothèque TLS était obsolète. Mise à jour de WinHTTP et correctif serveur pour prise en charge SHA-256.');

-- Ticket 7
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @maitreInvestissementId
           AND ProductVersionId = @version2_1Id
           AND OperatingSystemId = @androidId),
        @resoluStatusId,
        '20220602 00:00:00',
        '20220617 00:00:00',
        'les dividendes ne s''affichent pas dans le calendrier.',
        'Problème de fuseau horaire. Les dates étaient UTC mais interprétées localement. Correction via ZonedDateTime.');

-- Ticket 8
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @maitreInvestissementId
           AND ProductVersionId = @version2_1Id
           AND OperatingSystemId = @iOsId),
        @resoluStatusId,
        '20220715 00:00:00',
        '20220802 00:00:00',
        'VoiceOver ne lit pas les étiquettes d''actions.',
        'Attribut accessibilityLabel manquant. Ajout systématique dans les UILabel personnalisés.');

-- Ticket 9
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @maitreInvestissementId
           AND ProductVersionId = @version2_1Id
           AND OperatingSystemId = @windowsId),
        @enCoursStatusId,
        '20220704 00:00:00',
        NULL,
        'Lorsque l''utilisateur saisit un montant incluant des centimes, l''application arrondi le montant après validation',
        NULL);

-- Ticket 10
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @maitreInvestissementId
           AND ProductVersionId = @version2_1Id
           AND OperatingSystemId = @windowsId),
        @resoluStatusId,
        '20220704 00:00:00',
        '20220818 00:00:00',
        'doublons dans le PDF du rapport.',
        'Boucle foreach doublée suite à un mauvais filtrage LINQ. Correction du filtre de sélection unique des frais mensuels.');

-- Ticket 11
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @maitreInvestissementId
           AND ProductVersionId = @version2_1Id
           AND OperatingSystemId = @windowsId),
        @enCoursStatusId,
        '20220723 00:00:00',
        NULL,
        'Crash de l''application lorsque que l''utilisateur clique sur le sélecteur de fichier pour sauvegarder ses rapports',
        NULL);

-- Ticket 12
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @maitreInvestissementId
           AND ProductVersionId = @version2_1Id
           AND OperatingSystemId = @macOsId),
        @resoluStatusId,
        '20220223 00:00:00',
        '20220312 00:00:00',
        'iCloud Sync cassée après mise à jour Ventura',
        'iCloud Documents utilisait une ancienne API obsolète. Migration vers NSFileProvider.');

-- Ticket 13
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @maitreInvestissementId
           AND ProductVersionId = @version2_1Id
           AND OperatingSystemId = @androidId),
        @enCoursStatusId,
        '20220617 00:00:00',
        NULL,
        'Connexion bloquée en cas de changement de réseau.',
        NULL);

-- Ticket 14
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurAnxieteId
           AND ProductVersionId = @version1_0Id
           AND OperatingSystemId = @androidId),
        @resoluStatusId,
        '20210602 00:00:00',
        '20210623 00:00:00',
        'les rappels de respiration ne s''envoient pas si l''app est inactive.',
        'Passage du service en foreground service + AlarmManager.setExactAndAllowWhileIdle().');

-- Ticket 15
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurAnxieteId
           AND ProductVersionId = @version1_1Id
           AND OperatingSystemId = @iOsId),
        @resoluStatusId,
        '20220202 00:00:00',
        '20220323 00:00:00',
        'Les textes sont tronqués sur les iphones 6 à 8 hors série Plus dû à leurs petits écrans',
        'Passage à AutoLayout + adjustsFontSizeToFitWidth = true.');

-- Ticket 16
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurAnxieteId
           AND ProductVersionId = @version1_1Id
           AND OperatingSystemId = @windowsId),
        @resoluStatusId,
        '20220104 00:00:00',
        '20220217 00:00:00',
        'le thème sombre rend le texte illisible.',
        'Utilisation des ThemeResource au lieu de couleur fixe');

-- Ticket 17
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurAnxieteId
           AND ProductVersionId = @version1_1Id
           AND OperatingSystemId = @windowsId),
        @enCoursStatusId,
        '20220504 00:00:00',
        NULL,
        'impossible d''éditer un événement avec un clavier AZERTY.',
        NULL);

-- Ticket 18
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurAnxieteId
           AND ProductVersionId = @version1_0Id
           AND OperatingSystemId = @macOsId),
        @resoluStatusId,
        '20210404 00:00:00',
        '20210523 00:00:00',
        'export du journal vide.',
        'Fichier généré dans un dossier sans permission. Solution : sauvegarde dans ~/Documents + gestion des erreurs visible.');

-- Ticket 19
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurAnxieteId
           AND ProductVersionId = @version1_0Id
           AND OperatingSystemId = @androidId),
        @enCoursStatusId,
        '20210405 00:00:00',
        NULL,
        'Le minuteur de respiration se réinitialise environ 30 secondes avant la fin prévue',
        NULL);

-- Ticket 20
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurEntrainementId
           AND ProductVersionId = @version1_1Id
           AND OperatingSystemId = @androidId),
        @resoluStatusId,
        '20210903 00:00:00',
        '20211023 00:00:00',
        'GPS imprécis ou absent avec smartwatch.',
        'L''app utilisait uniquement le GPS du téléphone. Ajout de compatibilité avec Google Fit / WearOS API.');

-- Ticket 21
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurEntrainementId
           AND ProductVersionId = @version1_1Id
           AND OperatingSystemId = @iOsId),
        @resoluStatusId,
        '20210910 00:00:00',
        '20211015 00:00:00',
        'Une erreur se produit lors du démarrage d''une séance en français.',
        'Traduction manquante dans Localizable.xcstrings, ce qui causait un nil sur l''intitulé du bouton.');

-- Ticket 22
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurEntrainementId
           AND ProductVersionId = @version2_0Id
           AND OperatingSystemId = @windowsId),
        @resoluStatusId,
        '20201201 00:00:00',
        '20210202 00:00:00',
        'Les vidéos d''exercice ne se lance pas sur certaines machines AMD.',
        'Problème de codec vidéo H.264 manquant. Ajout d''un fallback avec FFMPEG intégré.');

-- Ticket 23
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurEntrainementId
           AND ProductVersionId = @version1_0Id
           AND OperatingSystemId = @macOsId),
        @enCoursStatusId,
        '20201202 00:00:00',
        NULL,
        'les statistiques hebdomadaires ne s''affichent pas si une séance est supprimée.',
        NULL);

-- Ticket 24
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurEntrainementId
           AND ProductVersionId = @version1_1Id
           AND OperatingSystemId = @windowsId),
        @enCoursStatusId,
        '20210505 00:00:00',
        NULL,
        'erreur d''accès au micro pendant l''enregistrement audio.',
        NULL);

-- Ticket 25
INSERT INTO dbo.Tickets(ProductId, StatutId, DateCreation, DateResolution, Problem, Resolution)
VALUES ((SELECT Id
         FROM dbo.Products
         WHERE ProductNameId = @planificateurEntrainementId
           AND ProductVersionId = @version1_1Id
           AND OperatingSystemId = @iOsId),
        @resoluStatusId,
        '20210607 00:00:00',
        '20210715 00:00:00',
        'les calories restent à 0 malgré une progression significative de certaines statistiques',
        'Algorithme de calcul dépendait du poids non défini. Ajout d''une vérification + suggestion utilisateur.');