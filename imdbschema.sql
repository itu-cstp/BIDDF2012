CREATE TABLE `genre` (
  `movieId` int(11) DEFAULT NULL,
  `genre` varchar(50) DEFAULT NULL,
  KEY `idx5` (`movieId`,`genre`),
  KEY `idx6` (`genre`,`movieId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

CREATE TABLE `involved` (
  `personId` int(11) DEFAULT NULL,
  `movieId` int(11) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  KEY `idx1` (`personId`,`movieId`),
  KEY `idx2` (`movieId`,`personId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

CREATE TABLE `movie` (
  `id` int(11) NOT NULL,
  `title` varchar(500) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `color` varchar(15) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `language` varchar(50) DEFAULT NULL,
  `distrVotes` varchar(10) DEFAULT NULL,
  `imdbVotes` int(11) DEFAULT NULL,
  `imdbRank` float DEFAULT NULL,
  `releaseDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx4` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

CREATE TABLE `movieref` (
  `fromId` int(11) DEFAULT NULL,
  `toId` int(11) DEFAULT NULL,
  KEY `idx7` (`fromId`,`toId`),
  KEY `idx8` (`toId`,`fromId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

CREATE TABLE `person` (
  `id` int(11) NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `deathdate` date DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx3` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;