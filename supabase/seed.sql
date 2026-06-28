SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict cudq6Sc9SmhNR0mz04KV8sngJaLpjkFTqDoC6JcQTqtuzaEZ0VPLqEOBoEB32dE

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: championship; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."championship" ("id", "name", "created_at") VALUES
	(1, 'Fotbolls-VM -26', '2026-06-12 18:14:40.731435+00');


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."player" ("id", "created_at", "name") VALUES
	(1, '2026-06-12 20:17:59.158922+00', 'Erik'),
	(2, '2026-06-12 20:18:12.087603+00', 'Karin'),
	(3, '2026-06-12 20:18:26.055971+00', 'Leif'),
	(4, '2026-06-15 18:55:29.011118+00', 'Eva'),
	(5, '2026-06-27 16:45:04.344998+00', 'Birgitta'),
	(6, '2026-06-27 16:45:23.496228+00', 'Tommy'),
	(7, '2026-06-27 16:45:44.046321+00', 'Stina'),
	(8, '2026-06-27 16:46:01.87184+00', 'Iulia'),
	(9, '2026-06-27 16:46:11.514625+00', 'Klara'),
	(10, '2026-06-27 16:46:21.040206+00', 'Aamos'),
	(11, '2026-06-27 16:46:38.534013+00', 'Lars'),
	(12, '2026-06-27 16:46:50.712178+00', 'Sandra'),
	(13, '2026-06-27 16:46:59.675531+00', 'Jakob'),
	(14, '2026-06-27 16:47:09.257167+00', 'Wellam'),
	(15, '2026-06-27 16:47:17.545898+00', 'Anja'),
	(16, '2026-06-27 16:47:31.735948+00', 'Pete'),
	(17, '2026-06-28 08:39:39.48593+00', 'Gabriel'),
	(18, '2026-06-28 08:39:49.451572+00', 'Mimmi');


--
-- Data for Name: round; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."round" ("id", "created_at", "championship_id", "name", "points", "end_time", "current") VALUES
	(1, '2026-06-12 18:19:36.917798+00', 1, 'Sextondelsfinaler', 1, '2026-06-28 19:00:00+00', true),
	(2, '2026-06-12 18:19:51.523127+00', 1, 'Åttondelsfinaler', 2, '2026-07-04 17:00:00+00', false),
	(3, '2026-06-12 18:20:07.878483+00', 1, 'Kvartsfinaler', 4, '2026-07-09 20:00:00+00', false),
	(4, '2026-06-12 18:20:20.240402+00', 1, 'Semifinaler', 8, '2026-07-14 19:00:00+00', false),
	(5, '2026-06-12 18:20:32.446656+00', 1, 'Final', 16, '2026-07-18 21:00:00+00', false);


--
-- Data for Name: prediction_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."prediction_item" ("id", "created_at", "round_id", "question", "options", "correct_answer", "tie_breaker", "points") VALUES
	(19, '2026-06-27 16:34:35.135551+00', 1, NULL, '["Sydafrika", "Kanada"]', NULL, false, NULL),
	(20, '2026-06-27 16:35:23.637572+00', 1, NULL, '["Brasilien", "Japan"]', NULL, false, NULL),
	(21, '2026-06-27 16:35:53.258275+00', 1, NULL, '["Tyskland", "Paraguay"]', NULL, false, NULL),
	(22, '2026-06-27 16:36:21.298377+00', 1, NULL, '["Nederländerna", "Marocko"]', NULL, false, NULL),
	(23, '2026-06-27 16:36:47.213438+00', 1, NULL, '["Elfenbenskusten", "Norge"]', NULL, false, NULL),
	(25, '2026-06-27 16:37:19.301916+00', 1, NULL, '["Frankrike", "Sverige"]', NULL, false, NULL),
	(29, '2026-06-27 16:40:17.154637+00', 1, NULL, '["USA", "Bosnien och Hercegovina"]', NULL, false, NULL),
	(34, '2026-06-27 16:42:14.03094+00', 1, NULL, '["Australien", "Egypten"]', NULL, false, NULL),
	(35, '2026-06-27 16:42:43.708147+00', 1, NULL, '["Argentina", "Kap Verde"]', NULL, false, NULL),
	(26, '2026-06-27 16:38:14.621067+00', 1, NULL, '["Mexiko","Ecuador"]', NULL, false, NULL),
	(27, '2026-06-27 16:38:41.451896+00', 1, NULL, '["England","DR Kongo"]', NULL, false, NULL),
	(28, '2026-06-27 16:39:05.205997+00', 1, NULL, '["Belgien","Senegal"]', NULL, false, NULL),
	(31, '2026-06-27 16:40:48.631128+00', 1, NULL, '["Spanien","Österrike"]', NULL, false, NULL),
	(32, '2026-06-27 16:41:12.950596+00', 1, NULL, '["Portugal","Kroatien"]', NULL, false, NULL),
	(33, '2026-06-27 16:41:51.997248+00', 1, NULL, '["Schweiz","Algeriet"]', NULL, false, NULL),
	(36, '2026-06-27 16:43:04.675884+00', 1, NULL, '["Colombia","Ghana"]', NULL, false, NULL);


--
-- Data for Name: prediction; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."prediction" ("id", "created_at", "player_id", "prediction_item_id", "value") VALUES
	(135, '2026-06-28 08:32:10.191861+00', 10, 19, '"Kanada"'),
	(136, '2026-06-28 08:32:10.191861+00', 10, 20, '"Japan"'),
	(137, '2026-06-28 08:32:10.191861+00', 10, 21, '"Tyskland"'),
	(138, '2026-06-28 08:32:10.191861+00', 10, 22, '"Marocko"'),
	(139, '2026-06-28 08:32:10.191861+00', 10, 23, '"Norge"'),
	(140, '2026-06-28 08:32:10.191861+00', 10, 25, '"Frankrike"'),
	(141, '2026-06-28 08:32:10.191861+00', 10, 26, '"Mexiko"'),
	(142, '2026-06-28 08:32:10.191861+00', 10, 27, '"England"'),
	(143, '2026-06-28 08:32:10.191861+00', 10, 28, '"Senegal"'),
	(144, '2026-06-28 08:32:10.191861+00', 10, 29, '"Bosnien och Hercegovina"'),
	(145, '2026-06-28 08:32:10.191861+00', 10, 31, '"Spanien"'),
	(146, '2026-06-28 08:32:10.191861+00', 10, 32, '"Kroatien"'),
	(147, '2026-06-28 08:32:10.191861+00', 10, 33, '"Schweiz"'),
	(148, '2026-06-28 08:32:10.191861+00', 10, 34, '"Egypten"'),
	(149, '2026-06-28 08:32:10.191861+00', 10, 35, '"Argentina"'),
	(150, '2026-06-28 08:32:10.191861+00', 10, 36, '"Ghana"'),
	(151, '2026-06-28 08:44:20.160475+00', 9, 19, '"Sydafrika"'),
	(152, '2026-06-28 08:44:20.160475+00', 9, 20, '"Brasilien"'),
	(153, '2026-06-28 08:44:20.160475+00', 9, 21, '"Tyskland"'),
	(154, '2026-06-28 08:44:20.160475+00', 9, 22, '"Nederländerna"'),
	(155, '2026-06-28 08:44:20.160475+00', 9, 23, '"Norge"'),
	(156, '2026-06-28 08:44:20.160475+00', 9, 25, '"Frankrike"'),
	(157, '2026-06-28 08:44:20.160475+00', 9, 26, '"Mexiko"'),
	(158, '2026-06-28 08:44:20.160475+00', 9, 27, '"England"'),
	(159, '2026-06-28 08:44:20.160475+00', 9, 28, '"Belgien"'),
	(160, '2026-06-28 08:44:20.160475+00', 9, 29, '"Bosnien och Hercegovina"'),
	(161, '2026-06-28 08:44:20.160475+00', 9, 31, '"Österrike"'),
	(162, '2026-06-28 08:44:20.160475+00', 9, 32, '"Portugal"'),
	(163, '2026-06-28 08:44:20.160475+00', 9, 33, '"Schweiz"'),
	(164, '2026-06-28 08:44:20.160475+00', 9, 34, '"Egypten"'),
	(165, '2026-06-28 08:44:20.160475+00', 9, 35, '"Argentina"'),
	(166, '2026-06-28 08:44:20.160475+00', 9, 36, '"Colombia"'),
	(167, '2026-06-28 08:45:06.274057+00', 18, 19, '"Kanada"'),
	(168, '2026-06-28 08:45:06.274057+00', 18, 20, '"Brasilien"'),
	(169, '2026-06-28 08:45:06.274057+00', 18, 21, '"Tyskland"'),
	(170, '2026-06-28 08:45:06.274057+00', 18, 22, '"Marocko"'),
	(171, '2026-06-28 08:45:06.274057+00', 18, 23, '"Norge"'),
	(172, '2026-06-28 08:45:06.274057+00', 18, 25, '"Sverige"'),
	(173, '2026-06-28 08:45:06.274057+00', 18, 26, '"Mexiko"'),
	(174, '2026-06-28 08:45:06.274057+00', 18, 27, '"England"'),
	(175, '2026-06-28 08:45:06.274057+00', 18, 28, '"Belgien"'),
	(176, '2026-06-28 08:45:06.274057+00', 18, 29, '"Bosnien och Hercegovina"'),
	(177, '2026-06-28 08:45:06.274057+00', 18, 31, '"Spanien"'),
	(178, '2026-06-28 08:45:06.274057+00', 18, 32, '"Portugal"'),
	(179, '2026-06-28 08:45:06.274057+00', 18, 33, '"Schweiz"'),
	(180, '2026-06-28 08:45:06.274057+00', 18, 34, '"Australien"'),
	(181, '2026-06-28 08:45:06.274057+00', 18, 35, '"Argentina"'),
	(182, '2026-06-28 08:45:06.274057+00', 18, 36, '"Colombia"'),
	(183, '2026-06-28 08:46:27.800365+00', 17, 19, '"Kanada"'),
	(184, '2026-06-28 08:46:27.800365+00', 17, 20, '"Brasilien"'),
	(185, '2026-06-28 08:46:27.800365+00', 17, 21, '"Tyskland"'),
	(186, '2026-06-28 08:46:27.800365+00', 17, 22, '"Marocko"'),
	(187, '2026-06-28 08:46:27.800365+00', 17, 23, '"Norge"'),
	(188, '2026-06-28 08:46:27.800365+00', 17, 25, '"Frankrike"'),
	(189, '2026-06-28 08:46:27.800365+00', 17, 26, '"Mexiko"'),
	(190, '2026-06-28 08:46:27.800365+00', 17, 27, '"England"'),
	(191, '2026-06-28 08:46:27.800365+00', 17, 28, '"Senegal"'),
	(192, '2026-06-28 08:46:27.800365+00', 17, 29, '"USA"'),
	(193, '2026-06-28 08:46:27.800365+00', 17, 31, '"Spanien"'),
	(194, '2026-06-28 08:46:27.800365+00', 17, 32, '"Kroatien"'),
	(195, '2026-06-28 08:46:27.800365+00', 17, 33, '"Algeriet"'),
	(196, '2026-06-28 08:46:27.800365+00', 17, 34, '"Egypten"'),
	(197, '2026-06-28 08:46:27.800365+00', 17, 35, '"Argentina"'),
	(198, '2026-06-28 08:46:27.800365+00', 17, 36, '"Colombia"'),
	(199, '2026-06-28 09:07:25.446128+00', 11, 19, '"Kanada"'),
	(200, '2026-06-28 09:07:25.446128+00', 11, 20, '"Brasilien"'),
	(201, '2026-06-28 09:07:25.446128+00', 11, 21, '"Tyskland"'),
	(202, '2026-06-28 09:07:25.446128+00', 11, 22, '"Marocko"'),
	(203, '2026-06-28 09:07:25.446128+00', 11, 23, '"Norge"'),
	(204, '2026-06-28 09:07:25.446128+00', 11, 25, '"Frankrike"'),
	(205, '2026-06-28 09:07:25.446128+00', 11, 26, '"Mexiko"'),
	(206, '2026-06-28 09:07:25.446128+00', 11, 27, '"England"'),
	(207, '2026-06-28 09:07:25.446128+00', 11, 28, '"Senegal"'),
	(208, '2026-06-28 09:07:25.446128+00', 11, 29, '"USA"'),
	(209, '2026-06-28 09:07:25.446128+00', 11, 31, '"Spanien"'),
	(210, '2026-06-28 09:07:25.446128+00', 11, 32, '"Kroatien"'),
	(211, '2026-06-28 09:07:25.446128+00', 11, 33, '"Schweiz"'),
	(212, '2026-06-28 09:07:25.446128+00', 11, 34, '"Egypten"'),
	(213, '2026-06-28 09:07:25.446128+00', 11, 35, '"Argentina"'),
	(214, '2026-06-28 09:07:25.446128+00', 11, 36, '"Colombia"'),
	(215, '2026-06-28 09:09:15.801601+00', 13, 19, '"Kanada"'),
	(216, '2026-06-28 09:09:15.801601+00', 13, 20, '"Japan"'),
	(217, '2026-06-28 09:09:15.801601+00', 13, 21, '"Tyskland"'),
	(218, '2026-06-28 09:09:15.801601+00', 13, 22, '"Nederländerna"'),
	(219, '2026-06-28 09:09:15.801601+00', 13, 23, '"Norge"'),
	(220, '2026-06-28 09:09:15.801601+00', 13, 25, '"Frankrike"'),
	(221, '2026-06-28 09:09:15.801601+00', 13, 26, '"Ecuador"'),
	(222, '2026-06-28 09:09:15.801601+00', 13, 27, '"England"'),
	(223, '2026-06-28 09:09:15.801601+00', 13, 28, '"Belgien"'),
	(224, '2026-06-28 09:09:15.801601+00', 13, 29, '"Bosnien och Hercegovina"'),
	(225, '2026-06-28 09:09:15.801601+00', 13, 31, '"Spanien"'),
	(226, '2026-06-28 09:09:15.801601+00', 13, 32, '"Portugal"'),
	(227, '2026-06-28 09:09:15.801601+00', 13, 33, '"Schweiz"'),
	(228, '2026-06-28 09:09:15.801601+00', 13, 34, '"Egypten"'),
	(229, '2026-06-28 09:09:15.801601+00', 13, 35, '"Argentina"'),
	(230, '2026-06-28 09:09:15.801601+00', 13, 36, '"Colombia"'),
	(231, '2026-06-28 09:44:31.834486+00', 5, 19, '"Kanada"'),
	(232, '2026-06-28 09:44:31.834486+00', 5, 20, '"Brasilien"'),
	(233, '2026-06-28 09:44:31.834486+00', 5, 21, '"Tyskland"'),
	(234, '2026-06-28 09:44:31.834486+00', 5, 22, '"Nederländerna"'),
	(235, '2026-06-28 09:44:31.834486+00', 5, 23, '"Elfenbenskusten"'),
	(236, '2026-06-28 09:44:31.834486+00', 5, 25, '"Frankrike"'),
	(237, '2026-06-28 09:44:31.834486+00', 5, 26, '"Mexiko"'),
	(238, '2026-06-28 09:44:31.834486+00', 5, 27, '"DR Kongo"'),
	(239, '2026-06-28 09:44:31.834486+00', 5, 28, '"Senegal"'),
	(240, '2026-06-28 09:44:31.834486+00', 5, 29, '"USA"'),
	(241, '2026-06-28 09:44:31.834486+00', 5, 31, '"Spanien"'),
	(242, '2026-06-28 09:44:31.834486+00', 5, 32, '"Kroatien"'),
	(243, '2026-06-28 09:44:31.834486+00', 5, 33, '"Schweiz"'),
	(244, '2026-06-28 09:44:31.834486+00', 5, 34, '"Egypten"'),
	(245, '2026-06-28 09:44:31.834486+00', 5, 35, '"Argentina"'),
	(246, '2026-06-28 09:44:31.834486+00', 5, 36, '"Ghana"'),
	(247, '2026-06-28 10:00:36.69734+00', 1, 19, '"Sydafrika"'),
	(248, '2026-06-28 10:00:36.69734+00', 1, 20, '"Brasilien"'),
	(249, '2026-06-28 10:00:36.69734+00', 1, 21, '"Tyskland"'),
	(250, '2026-06-28 10:00:36.69734+00', 1, 22, '"Marocko"'),
	(251, '2026-06-28 10:00:36.69734+00', 1, 23, '"Norge"'),
	(252, '2026-06-28 10:00:36.69734+00', 1, 25, '"Frankrike"'),
	(253, '2026-06-28 10:00:36.69734+00', 1, 26, '"Mexiko"'),
	(254, '2026-06-28 10:00:36.69734+00', 1, 27, '"England"'),
	(255, '2026-06-28 10:00:36.69734+00', 1, 28, '"Belgien"'),
	(256, '2026-06-28 10:00:36.69734+00', 1, 29, '"USA"'),
	(257, '2026-06-28 10:00:36.69734+00', 1, 31, '"Spanien"'),
	(258, '2026-06-28 10:00:36.69734+00', 1, 32, '"Portugal"'),
	(259, '2026-06-28 10:00:36.69734+00', 1, 33, '"Schweiz"'),
	(260, '2026-06-28 10:00:36.69734+00', 1, 34, '"Egypten"'),
	(261, '2026-06-28 10:00:36.69734+00', 1, 35, '"Argentina"'),
	(262, '2026-06-28 10:00:36.69734+00', 1, 36, '"Colombia"'),
	(263, '2026-06-28 11:16:17.196233+00', 3, 19, '"Kanada"'),
	(264, '2026-06-28 11:16:17.196233+00', 3, 20, '"Brasilien"'),
	(265, '2026-06-28 11:16:17.196233+00', 3, 21, '"Tyskland"'),
	(266, '2026-06-28 11:16:17.196233+00', 3, 22, '"Nederländerna"'),
	(267, '2026-06-28 11:16:17.196233+00', 3, 23, '"Norge"'),
	(268, '2026-06-28 11:16:17.196233+00', 3, 25, '"Frankrike"'),
	(269, '2026-06-28 11:16:17.196233+00', 3, 26, '"Mexiko"'),
	(270, '2026-06-28 11:16:17.196233+00', 3, 27, '"England"'),
	(271, '2026-06-28 11:16:17.196233+00', 3, 28, '"Belgien"'),
	(272, '2026-06-28 11:16:17.196233+00', 3, 29, '"USA"'),
	(273, '2026-06-28 11:16:17.196233+00', 3, 31, '"Spanien"'),
	(274, '2026-06-28 11:16:17.196233+00', 3, 32, '"Kroatien"'),
	(275, '2026-06-28 11:16:17.196233+00', 3, 33, '"Schweiz"'),
	(276, '2026-06-28 11:16:17.196233+00', 3, 34, '"Australien"'),
	(277, '2026-06-28 11:16:17.196233+00', 3, 35, '"Argentina"'),
	(278, '2026-06-28 11:16:17.196233+00', 3, 36, '"Ghana"'),
	(279, '2026-06-28 14:30:43.151645+00', 12, 19, '"Kanada"'),
	(280, '2026-06-28 14:30:43.151645+00', 12, 20, '"Brasilien"'),
	(281, '2026-06-28 14:30:43.151645+00', 12, 21, '"Tyskland"'),
	(282, '2026-06-28 14:30:43.151645+00', 12, 22, '"Nederländerna"'),
	(283, '2026-06-28 14:30:43.151645+00', 12, 23, '"Elfenbenskusten"'),
	(284, '2026-06-28 14:30:43.151645+00', 12, 25, '"Frankrike"'),
	(285, '2026-06-28 14:30:43.151645+00', 12, 26, '"Mexiko"'),
	(286, '2026-06-28 14:30:43.151645+00', 12, 27, '"England"'),
	(287, '2026-06-28 14:30:43.151645+00', 12, 28, '"Senegal"'),
	(288, '2026-06-28 14:30:43.151645+00', 12, 29, '"Bosnien och Hercegovina"'),
	(289, '2026-06-28 14:30:43.151645+00', 12, 31, '"Spanien"'),
	(290, '2026-06-28 14:30:43.151645+00', 12, 32, '"Portugal"'),
	(291, '2026-06-28 14:30:43.151645+00', 12, 33, '"Schweiz"'),
	(292, '2026-06-28 14:30:43.151645+00', 12, 34, '"Australien"'),
	(293, '2026-06-28 14:30:43.151645+00', 12, 35, '"Argentina"'),
	(294, '2026-06-28 14:30:43.151645+00', 12, 36, '"Colombia"'),
	(295, '2026-06-28 17:23:30.083541+00', 6, 19, '"Kanada"'),
	(296, '2026-06-28 17:23:30.083541+00', 6, 20, '"Brasilien"'),
	(297, '2026-06-28 17:23:30.083541+00', 6, 21, '"Tyskland"'),
	(298, '2026-06-28 17:23:30.083541+00', 6, 22, '"Marocko"'),
	(299, '2026-06-28 17:23:30.083541+00', 6, 23, '"Norge"'),
	(300, '2026-06-28 17:23:30.083541+00', 6, 25, '"Frankrike"'),
	(301, '2026-06-28 17:23:30.083541+00', 6, 26, '"Mexiko"'),
	(302, '2026-06-28 17:23:30.083541+00', 6, 27, '"England"'),
	(303, '2026-06-28 17:23:30.083541+00', 6, 28, '"Belgien"'),
	(304, '2026-06-28 17:23:30.083541+00', 6, 29, '"USA"'),
	(305, '2026-06-28 17:23:30.083541+00', 6, 31, '"Spanien"'),
	(306, '2026-06-28 17:23:30.083541+00', 6, 32, '"Portugal"'),
	(307, '2026-06-28 17:23:30.083541+00', 6, 33, '"Schweiz"'),
	(308, '2026-06-28 17:23:30.083541+00', 6, 34, '"Egypten"'),
	(309, '2026-06-28 17:23:30.083541+00', 6, 35, '"Argentina"'),
	(310, '2026-06-28 17:23:30.083541+00', 6, 36, '"Colombia"'),
	(311, '2026-06-28 17:30:36.913759+00', 2, 19, '"Sydafrika"'),
	(312, '2026-06-28 17:30:36.913759+00', 2, 20, '"Brasilien"'),
	(313, '2026-06-28 17:30:36.913759+00', 2, 21, '"Tyskland"'),
	(314, '2026-06-28 17:30:36.913759+00', 2, 22, '"Nederländerna"'),
	(315, '2026-06-28 17:30:36.913759+00', 2, 23, '"Norge"'),
	(316, '2026-06-28 17:30:36.913759+00', 2, 25, '"Frankrike"'),
	(317, '2026-06-28 17:30:36.913759+00', 2, 26, '"Mexiko"'),
	(318, '2026-06-28 17:30:36.913759+00', 2, 27, '"England"'),
	(319, '2026-06-28 17:30:36.913759+00', 2, 28, '"Senegal"'),
	(320, '2026-06-28 17:30:36.913759+00', 2, 29, '"Bosnien och Hercegovina"'),
	(321, '2026-06-28 17:30:36.913759+00', 2, 31, '"Spanien"'),
	(322, '2026-06-28 17:30:36.913759+00', 2, 32, '"Portugal"'),
	(323, '2026-06-28 17:30:36.913759+00', 2, 33, '"Schweiz"'),
	(324, '2026-06-28 17:30:36.913759+00', 2, 34, '"Australien"'),
	(325, '2026-06-28 17:30:36.913759+00', 2, 35, '"Argentina"'),
	(326, '2026-06-28 17:30:36.913759+00', 2, 36, '"Colombia"'),
	(327, '2026-06-28 17:31:14.804824+00', 14, 19, '"Kanada"'),
	(328, '2026-06-28 17:31:14.804824+00', 14, 20, '"Brasilien"'),
	(329, '2026-06-28 17:31:14.804824+00', 14, 21, '"Tyskland"'),
	(330, '2026-06-28 17:31:14.804824+00', 14, 22, '"Nederländerna"'),
	(331, '2026-06-28 17:31:14.804824+00', 14, 23, '"Norge"'),
	(332, '2026-06-28 17:31:14.804824+00', 14, 25, '"Frankrike"'),
	(333, '2026-06-28 17:31:14.804824+00', 14, 26, '"Mexiko"'),
	(334, '2026-06-28 17:31:14.804824+00', 14, 27, '"England"'),
	(335, '2026-06-28 17:31:14.804824+00', 14, 28, '"Belgien"'),
	(336, '2026-06-28 17:31:14.804824+00', 14, 29, '"USA"'),
	(337, '2026-06-28 17:31:14.804824+00', 14, 31, '"Spanien"'),
	(338, '2026-06-28 17:31:14.804824+00', 14, 32, '"Portugal"'),
	(339, '2026-06-28 17:31:14.804824+00', 14, 33, '"Schweiz"'),
	(340, '2026-06-28 17:31:14.804824+00', 14, 34, '"Australien"'),
	(341, '2026-06-28 17:31:14.804824+00', 14, 35, '"Argentina"'),
	(342, '2026-06-28 17:31:14.804824+00', 14, 36, '"Ghana"'),
	(343, '2026-06-28 17:31:59.47805+00', 4, 19, '"Kanada"'),
	(344, '2026-06-28 17:31:59.47805+00', 4, 20, '"Japan"'),
	(345, '2026-06-28 17:31:59.47805+00', 4, 21, '"Paraguay"'),
	(346, '2026-06-28 17:31:59.47805+00', 4, 22, '"Nederländerna"'),
	(347, '2026-06-28 17:31:59.47805+00', 4, 23, '"Norge"'),
	(348, '2026-06-28 17:31:59.47805+00', 4, 25, '"Frankrike"'),
	(349, '2026-06-28 17:31:59.47805+00', 4, 26, '"Mexiko"'),
	(350, '2026-06-28 17:31:59.47805+00', 4, 27, '"England"'),
	(351, '2026-06-28 17:31:59.47805+00', 4, 28, '"Senegal"'),
	(352, '2026-06-28 17:31:59.47805+00', 4, 29, '"Bosnien och Hercegovina"'),
	(353, '2026-06-28 17:31:59.47805+00', 4, 31, '"Spanien"'),
	(354, '2026-06-28 17:31:59.47805+00', 4, 32, '"Kroatien"'),
	(355, '2026-06-28 17:31:59.47805+00', 4, 33, '"Algeriet"'),
	(356, '2026-06-28 17:31:59.47805+00', 4, 34, '"Egypten"'),
	(357, '2026-06-28 17:31:59.47805+00', 4, 35, '"Argentina"'),
	(358, '2026-06-28 17:31:59.47805+00', 4, 36, '"Ghana"');


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, false);


--
-- Name: championship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."championship_id_seq"', 1, true);


--
-- Name: player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."player_id_seq"', 18, true);


--
-- Name: prediction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."prediction_id_seq"', 358, true);


--
-- Name: prediction_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."prediction_item_id_seq"', 36, true);


--
-- Name: round_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."round_id_seq"', 5, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict cudq6Sc9SmhNR0mz04KV8sngJaLpjkFTqDoC6JcQTqtuzaEZ0VPLqEOBoEB32dE

RESET ALL;
