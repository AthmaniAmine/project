PGDMP                       }            DZ_ARTISANS    17.2    17.2 _    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16384    DZ_ARTISANS    DATABASE     �   CREATE DATABASE "DZ_ARTISANS" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "DZ_ARTISANS";
                     postgres    false            n           1247    16630    paiement_confirme_par_enum    TYPE     g   CREATE TYPE public.paiement_confirme_par_enum AS ENUM (
    'client',
    'artisan',
    'les deux'
);
 -   DROP TYPE public.paiement_confirme_par_enum;
       public               postgres    false            k           1247    16624    statut_paiement_enum    TYPE     S   CREATE TYPE public.statut_paiement_enum AS ENUM (
    'en attente',
    'payee'
);
 '   DROP TYPE public.statut_paiement_enum;
       public               postgres    false            h           1247    16617    statut_reponse_enum    TYPE     d   CREATE TYPE public.statut_reponse_enum AS ENUM (
    'en attente',
    'acceptee',
    'refusee'
);
 &   DROP TYPE public.statut_reponse_enum;
       public               postgres    false            b           1247    16386    type_utilisateur_enum    TYPE     b   CREATE TYPE public.type_utilisateur_enum AS ENUM (
    'client',
    'artisan',
    'les deux'
);
 (   DROP TYPE public.type_utilisateur_enum;
       public               postgres    false            �            1255    24589    remove_expired_otps()    FUNCTION       CREATE FUNCTION public.remove_expired_otps() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (NEW.otp IS NOT NULL AND CURRENT_TIMESTAMP - NEW.otp_created_at > INTERVAL '5 minutes') THEN
        NEW.otp := NULL;
    END IF;
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.remove_expired_otps();
       public               postgres    false            �            1259    32833    artisandevisstatus    TABLE     �  CREATE TABLE public.artisandevisstatus (
    artisandevisstatusid integer NOT NULL,
    artisanid integer,
    devisid integer,
    status character varying(20) DEFAULT 'Pending'::character varying,
    CONSTRAINT artisandevisstatus_status_check CHECK (((status)::text = ANY ((ARRAY['Pending'::character varying, 'Viewed'::character varying, 'Deleted'::character varying, 'accepted'::character varying])::text[])))
);
 &   DROP TABLE public.artisandevisstatus;
       public         heap r       postgres    false            �            1259    32832 +   artisandevisstatus_artisandevisstatusid_seq    SEQUENCE     �   CREATE SEQUENCE public.artisandevisstatus_artisandevisstatusid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.artisandevisstatus_artisandevisstatusid_seq;
       public               postgres    false    232            �           0    0 +   artisandevisstatus_artisandevisstatusid_seq    SEQUENCE OWNED BY     {   ALTER SEQUENCE public.artisandevisstatus_artisandevisstatusid_seq OWNED BY public.artisandevisstatus.artisandevisstatusid;
          public               postgres    false    231            �            1259    32797    artisanresponse    TABLE       CREATE TABLE public.artisanresponse (
    responseid integer NOT NULL,
    devisid integer,
    artisanid integer,
    tempsestime character varying(50),
    prixpropose numeric(10,2),
    dateresponse timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) DEFAULT 'Pending'::character varying,
    CONSTRAINT artisanresponse_status_check CHECK (((status)::text = ANY ((ARRAY['Pending'::character varying, 'Accepted'::character varying, 'Rejected'::character varying])::text[])))
);
 #   DROP TABLE public.artisanresponse;
       public         heap r       postgres    false            �            1259    32796    artisanresponse_responseid_seq    SEQUENCE     �   CREATE SEQUENCE public.artisanresponse_responseid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.artisanresponse_responseid_seq;
       public               postgres    false    230            �           0    0    artisanresponse_responseid_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.artisanresponse_responseid_seq OWNED BY public.artisanresponse.responseid;
          public               postgres    false    229            �            1259    32869    certificates    TABLE       CREATE TABLE public.certificates (
    certificateid integer NOT NULL,
    artisanid integer,
    certificatename character varying(255) NOT NULL,
    description text,
    filepath character varying(255) NOT NULL,
    dateadded timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.certificates;
       public         heap r       postgres    false            �            1259    32868    certificates_certificateid_seq    SEQUENCE     �   CREATE SEQUENCE public.certificates_certificateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.certificates_certificateid_seq;
       public               postgres    false    236            �           0    0    certificates_certificateid_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.certificates_certificateid_seq OWNED BY public.certificates.certificateid;
          public               postgres    false    235            �            1259    32782    demandedevis    TABLE     Z  CREATE TABLE public.demandedevis (
    devisid integer NOT NULL,
    clientid integer,
    adresse text,
    telephone character varying(15),
    coutmax numeric(10,2),
    typeservice character varying(100),
    datelimite date,
    nomprojet text,
    datedemande timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    serviceid integer
);
     DROP TABLE public.demandedevis;
       public         heap r       postgres    false            �            1259    32781    demandedevis_devisid_seq    SEQUENCE     �   CREATE SEQUENCE public.demandedevis_devisid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.demandedevis_devisid_seq;
       public               postgres    false    228            �           0    0    demandedevis_devisid_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.demandedevis_devisid_seq OWNED BY public.demandedevis.devisid;
          public               postgres    false    227            �            1259    16727    messages    TABLE     �   CREATE TABLE public.messages (
    id integer NOT NULL,
    message text NOT NULL,
    date_envoi timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expediteur_id integer NOT NULL,
    destinataire_id integer NOT NULL
);
    DROP TABLE public.messages;
       public         heap r       postgres    false            �            1259    16726    messages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.messages_id_seq;
       public               postgres    false    224            �           0    0    messages_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;
          public               postgres    false    223            �            1259    32854 	   portfolio    TABLE     
  CREATE TABLE public.portfolio (
    projectid integer NOT NULL,
    artisanid integer,
    projectname character varying(255) NOT NULL,
    description text,
    imageurl character varying(255),
    dateadded timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.portfolio;
       public         heap r       postgres    false            �            1259    32853    portfolio_projectid_seq    SEQUENCE     �   CREATE SEQUENCE public.portfolio_projectid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.portfolio_projectid_seq;
       public               postgres    false    234            �           0    0    portfolio_projectid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.portfolio_projectid_seq OWNED BY public.portfolio.projectid;
          public               postgres    false    233            �            1259    24577    primuser    TABLE     �  CREATE TABLE public.primuser (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    prenom character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    otp character varying(10),
    otp_created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.primuser;
       public         heap r       postgres    false            �            1259    24576    primuser_id_seq    SEQUENCE     �   CREATE SEQUENCE public.primuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.primuser_id_seq;
       public               postgres    false    226            �           0    0    primuser_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.primuser_id_seq OWNED BY public.primuser.id;
          public               postgres    false    225            �            1259    16649    profilsartisans    TABLE     #  CREATE TABLE public.profilsartisans (
    id integer NOT NULL,
    date_creation timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    service_id integer,
    wilaya character varying(255),
    address character varying(255),
    phone_number character varying(15),
    description text,
    sexe character varying(10),
    prix numeric(10,2),
    nom character varying(255),
    prenom character varying(255),
    email text,
    photo_de_profil character varying(255) DEFAULT 'http://localhost:4000/upload/profil.png'::character varying
);
 #   DROP TABLE public.profilsartisans;
       public         heap r       postgres    false            �            1259    16648    profilsartisans_id_seq    SEQUENCE     �   CREATE SEQUENCE public.profilsartisans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.profilsartisans_id_seq;
       public               postgres    false    222            �           0    0    profilsartisans_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.profilsartisans_id_seq OWNED BY public.profilsartisans.id;
          public               postgres    false    221            �            1259    16638    services    TABLE     1  CREATE TABLE public.services (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    description text,
    date_creation timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    date_mise_a_jour timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cover character varying(2083)
);
    DROP TABLE public.services;
       public         heap r       postgres    false            �            1259    16637    services_id_seq    SEQUENCE     �   CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.services_id_seq;
       public               postgres    false    220            �           0    0    services_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;
          public               postgres    false    219            �            1259    16394    utilisateurs    TABLE     O  CREATE TABLE public.utilisateurs (
    id integer NOT NULL,
    nom character varying(255),
    email character varying(255) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    date_creation timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    date_mise_a_jour timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    type_utilisateur public.type_utilisateur_enum DEFAULT 'client'::public.type_utilisateur_enum NOT NULL,
    prenom character varying(255),
    photo_de_profil character varying(255) DEFAULT 'http://localhost:4000/upload/profil.png'::character varying
);
     DROP TABLE public.utilisateurs;
       public         heap r       postgres    false    866    866            �            1259    16393    utilisateurs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.utilisateurs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.utilisateurs_id_seq;
       public               postgres    false    218            �           0    0    utilisateurs_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.utilisateurs_id_seq OWNED BY public.utilisateurs.id;
          public               postgres    false    217            �           2604    32836 '   artisandevisstatus artisandevisstatusid    DEFAULT     �   ALTER TABLE ONLY public.artisandevisstatus ALTER COLUMN artisandevisstatusid SET DEFAULT nextval('public.artisandevisstatus_artisandevisstatusid_seq'::regclass);
 V   ALTER TABLE public.artisandevisstatus ALTER COLUMN artisandevisstatusid DROP DEFAULT;
       public               postgres    false    231    232    232            �           2604    32800    artisanresponse responseid    DEFAULT     �   ALTER TABLE ONLY public.artisanresponse ALTER COLUMN responseid SET DEFAULT nextval('public.artisanresponse_responseid_seq'::regclass);
 I   ALTER TABLE public.artisanresponse ALTER COLUMN responseid DROP DEFAULT;
       public               postgres    false    230    229    230            �           2604    32872    certificates certificateid    DEFAULT     �   ALTER TABLE ONLY public.certificates ALTER COLUMN certificateid SET DEFAULT nextval('public.certificates_certificateid_seq'::regclass);
 I   ALTER TABLE public.certificates ALTER COLUMN certificateid DROP DEFAULT;
       public               postgres    false    235    236    236            �           2604    32785    demandedevis devisid    DEFAULT     |   ALTER TABLE ONLY public.demandedevis ALTER COLUMN devisid SET DEFAULT nextval('public.demandedevis_devisid_seq'::regclass);
 C   ALTER TABLE public.demandedevis ALTER COLUMN devisid DROP DEFAULT;
       public               postgres    false    227    228    228            �           2604    16730    messages id    DEFAULT     j   ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);
 :   ALTER TABLE public.messages ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223    224            �           2604    32857    portfolio projectid    DEFAULT     z   ALTER TABLE ONLY public.portfolio ALTER COLUMN projectid SET DEFAULT nextval('public.portfolio_projectid_seq'::regclass);
 B   ALTER TABLE public.portfolio ALTER COLUMN projectid DROP DEFAULT;
       public               postgres    false    234    233    234            �           2604    24580    primuser id    DEFAULT     j   ALTER TABLE ONLY public.primuser ALTER COLUMN id SET DEFAULT nextval('public.primuser_id_seq'::regclass);
 :   ALTER TABLE public.primuser ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    225    226    226            �           2604    16652    profilsartisans id    DEFAULT     x   ALTER TABLE ONLY public.profilsartisans ALTER COLUMN id SET DEFAULT nextval('public.profilsartisans_id_seq'::regclass);
 A   ALTER TABLE public.profilsartisans ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    221    222    222            �           2604    16641    services id    DEFAULT     j   ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);
 :   ALTER TABLE public.services ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    219    220    220            �           2604    16397    utilisateurs id    DEFAULT     r   ALTER TABLE ONLY public.utilisateurs ALTER COLUMN id SET DEFAULT nextval('public.utilisateurs_id_seq'::regclass);
 >   ALTER TABLE public.utilisateurs ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            �          0    32833    artisandevisstatus 
   TABLE DATA           ^   COPY public.artisandevisstatus (artisandevisstatusid, artisanid, devisid, status) FROM stdin;
    public               postgres    false    232   S�       �          0    32797    artisanresponse 
   TABLE DATA           y   COPY public.artisanresponse (responseid, devisid, artisanid, tempsestime, prixpropose, dateresponse, status) FROM stdin;
    public               postgres    false    230   p�       �          0    32869    certificates 
   TABLE DATA           s   COPY public.certificates (certificateid, artisanid, certificatename, description, filepath, dateadded) FROM stdin;
    public               postgres    false    236   ��       �          0    32782    demandedevis 
   TABLE DATA           �   COPY public.demandedevis (devisid, clientid, adresse, telephone, coutmax, typeservice, datelimite, nomprojet, datedemande, serviceid) FROM stdin;
    public               postgres    false    228   �       �          0    16727    messages 
   TABLE DATA           [   COPY public.messages (id, message, date_envoi, expediteur_id, destinataire_id) FROM stdin;
    public               postgres    false    224   �       �          0    32854 	   portfolio 
   TABLE DATA           h   COPY public.portfolio (projectid, artisanid, projectname, description, imageurl, dateadded) FROM stdin;
    public               postgres    false    234   <�       �          0    24577    primuser 
   TABLE DATA           e   COPY public.primuser (id, nom, prenom, email, password, otp, otp_created_at, created_at) FROM stdin;
    public               postgres    false    226   ʁ       �          0    16649    profilsartisans 
   TABLE DATA           �   COPY public.profilsartisans (id, date_creation, service_id, wilaya, address, phone_number, description, sexe, prix, nom, prenom, email, photo_de_profil) FROM stdin;
    public               postgres    false    222   �       �          0    16638    services 
   TABLE DATA           `   COPY public.services (id, nom, description, date_creation, date_mise_a_jour, cover) FROM stdin;
    public               postgres    false    220   ��       �          0    16394    utilisateurs 
   TABLE DATA           �   COPY public.utilisateurs (id, nom, email, mot_de_passe, date_creation, date_mise_a_jour, type_utilisateur, prenom, photo_de_profil) FROM stdin;
    public               postgres    false    218   ��       �           0    0 +   artisandevisstatus_artisandevisstatusid_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.artisandevisstatus_artisandevisstatusid_seq', 1, false);
          public               postgres    false    231            �           0    0    artisanresponse_responseid_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.artisanresponse_responseid_seq', 1, false);
          public               postgres    false    229            �           0    0    certificates_certificateid_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.certificates_certificateid_seq', 1, true);
          public               postgres    false    235            �           0    0    demandedevis_devisid_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.demandedevis_devisid_seq', 1, false);
          public               postgres    false    227            �           0    0    messages_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.messages_id_seq', 1, false);
          public               postgres    false    223            �           0    0    portfolio_projectid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.portfolio_projectid_seq', 2, true);
          public               postgres    false    233            �           0    0    primuser_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.primuser_id_seq', 4, true);
          public               postgres    false    225            �           0    0    profilsartisans_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.profilsartisans_id_seq', 2, true);
          public               postgres    false    221            �           0    0    services_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.services_id_seq', 6, true);
          public               postgres    false    219            �           0    0    utilisateurs_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.utilisateurs_id_seq', 35, true);
          public               postgres    false    217            �           2606    32842 ;   artisandevisstatus artisandevisstatus_artisanid_devisid_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.artisandevisstatus
    ADD CONSTRAINT artisandevisstatus_artisanid_devisid_key UNIQUE (artisanid, devisid);
 e   ALTER TABLE ONLY public.artisandevisstatus DROP CONSTRAINT artisandevisstatus_artisanid_devisid_key;
       public                 postgres    false    232    232            �           2606    32840 *   artisandevisstatus artisandevisstatus_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.artisandevisstatus
    ADD CONSTRAINT artisandevisstatus_pkey PRIMARY KEY (artisandevisstatusid);
 T   ALTER TABLE ONLY public.artisandevisstatus DROP CONSTRAINT artisandevisstatus_pkey;
       public                 postgres    false    232            �           2606    32805 $   artisanresponse artisanresponse_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.artisanresponse
    ADD CONSTRAINT artisanresponse_pkey PRIMARY KEY (responseid);
 N   ALTER TABLE ONLY public.artisanresponse DROP CONSTRAINT artisanresponse_pkey;
       public                 postgres    false    230            �           2606    32877    certificates certificates_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.certificates
    ADD CONSTRAINT certificates_pkey PRIMARY KEY (certificateid);
 H   ALTER TABLE ONLY public.certificates DROP CONSTRAINT certificates_pkey;
       public                 postgres    false    236            �           2606    32790    demandedevis demandedevis_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.demandedevis
    ADD CONSTRAINT demandedevis_pkey PRIMARY KEY (devisid);
 H   ALTER TABLE ONLY public.demandedevis DROP CONSTRAINT demandedevis_pkey;
       public                 postgres    false    228            �           2606    16735    messages messages_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_pkey;
       public                 postgres    false    224            �           2606    32862    portfolio portfolio_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.portfolio
    ADD CONSTRAINT portfolio_pkey PRIMARY KEY (projectid);
 B   ALTER TABLE ONLY public.portfolio DROP CONSTRAINT portfolio_pkey;
       public                 postgres    false    234            �           2606    24588    primuser primuser_email_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.primuser
    ADD CONSTRAINT primuser_email_key UNIQUE (email);
 E   ALTER TABLE ONLY public.primuser DROP CONSTRAINT primuser_email_key;
       public                 postgres    false    226            �           2606    24586    primuser primuser_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.primuser
    ADD CONSTRAINT primuser_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.primuser DROP CONSTRAINT primuser_pkey;
       public                 postgres    false    226            �           2606    16656 $   profilsartisans profilsartisans_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.profilsartisans
    ADD CONSTRAINT profilsartisans_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.profilsartisans DROP CONSTRAINT profilsartisans_pkey;
       public                 postgres    false    222            �           2606    16647    services services_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.services DROP CONSTRAINT services_pkey;
       public                 postgres    false    220            �           2606    16406 #   utilisateurs utilisateurs_email_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_email_key UNIQUE (email);
 M   ALTER TABLE ONLY public.utilisateurs DROP CONSTRAINT utilisateurs_email_key;
       public                 postgres    false    218            �           2606    16404    utilisateurs utilisateurs_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.utilisateurs DROP CONSTRAINT utilisateurs_pkey;
       public                 postgres    false    218                       2620    24590 $   primuser trigger_remove_expired_otps    TRIGGER     �   CREATE TRIGGER trigger_remove_expired_otps BEFORE INSERT OR UPDATE ON public.primuser FOR EACH ROW EXECUTE FUNCTION public.remove_expired_otps();
 =   DROP TRIGGER trigger_remove_expired_otps ON public.primuser;
       public               postgres    false    226    237            �           2606    32843 4   artisandevisstatus artisandevisstatus_artisanid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.artisandevisstatus
    ADD CONSTRAINT artisandevisstatus_artisanid_fkey FOREIGN KEY (artisanid) REFERENCES public.profilsartisans(id);
 ^   ALTER TABLE ONLY public.artisandevisstatus DROP CONSTRAINT artisandevisstatus_artisanid_fkey;
       public               postgres    false    4836    232    222                        2606    32848 2   artisandevisstatus artisandevisstatus_devisid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.artisandevisstatus
    ADD CONSTRAINT artisandevisstatus_devisid_fkey FOREIGN KEY (devisid) REFERENCES public.demandedevis(devisid);
 \   ALTER TABLE ONLY public.artisandevisstatus DROP CONSTRAINT artisandevisstatus_devisid_fkey;
       public               postgres    false    4844    232    228            �           2606    32811 .   artisanresponse artisanresponse_artisanid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.artisanresponse
    ADD CONSTRAINT artisanresponse_artisanid_fkey FOREIGN KEY (artisanid) REFERENCES public.profilsartisans(id);
 X   ALTER TABLE ONLY public.artisanresponse DROP CONSTRAINT artisanresponse_artisanid_fkey;
       public               postgres    false    4836    222    230            �           2606    32806 ,   artisanresponse artisanresponse_devisid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.artisanresponse
    ADD CONSTRAINT artisanresponse_devisid_fkey FOREIGN KEY (devisid) REFERENCES public.demandedevis(devisid);
 V   ALTER TABLE ONLY public.artisanresponse DROP CONSTRAINT artisanresponse_devisid_fkey;
       public               postgres    false    4844    230    228                       2606    32878 (   certificates certificates_artisanid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.certificates
    ADD CONSTRAINT certificates_artisanid_fkey FOREIGN KEY (artisanid) REFERENCES public.profilsartisans(id);
 R   ALTER TABLE ONLY public.certificates DROP CONSTRAINT certificates_artisanid_fkey;
       public               postgres    false    4836    236    222            �           2606    32791 '   demandedevis demandedevis_clientid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.demandedevis
    ADD CONSTRAINT demandedevis_clientid_fkey FOREIGN KEY (clientid) REFERENCES public.utilisateurs(id);
 Q   ALTER TABLE ONLY public.demandedevis DROP CONSTRAINT demandedevis_clientid_fkey;
       public               postgres    false    4832    228    218            �           2606    32816 (   demandedevis demandedevis_serviceid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.demandedevis
    ADD CONSTRAINT demandedevis_serviceid_fkey FOREIGN KEY (serviceid) REFERENCES public.services(id);
 R   ALTER TABLE ONLY public.demandedevis DROP CONSTRAINT demandedevis_serviceid_fkey;
       public               postgres    false    4834    220    228            �           2606    32776 /   profilsartisans fk_profilsartisans_utilisateurs    FK CONSTRAINT     �   ALTER TABLE ONLY public.profilsartisans
    ADD CONSTRAINT fk_profilsartisans_utilisateurs FOREIGN KEY (id) REFERENCES public.utilisateurs(id);
 Y   ALTER TABLE ONLY public.profilsartisans DROP CONSTRAINT fk_profilsartisans_utilisateurs;
       public               postgres    false    4832    218    222            �           2606    16741 &   messages messages_destinataire_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_destinataire_id_fkey FOREIGN KEY (destinataire_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_destinataire_id_fkey;
       public               postgres    false    218    224    4832            �           2606    16736 $   messages messages_expediteur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_expediteur_id_fkey FOREIGN KEY (expediteur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_expediteur_id_fkey;
       public               postgres    false    218    4832    224                       2606    32863 "   portfolio portfolio_artisanid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.portfolio
    ADD CONSTRAINT portfolio_artisanid_fkey FOREIGN KEY (artisanid) REFERENCES public.profilsartisans(id);
 L   ALTER TABLE ONLY public.portfolio DROP CONSTRAINT portfolio_artisanid_fkey;
       public               postgres    false    222    234    4836            �           2606    16662 /   profilsartisans profilsartisans_service_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.profilsartisans
    ADD CONSTRAINT profilsartisans_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.profilsartisans DROP CONSTRAINT profilsartisans_service_id_fkey;
       public               postgres    false    222    220    4834            �      x������ � �      �      x������ � �      �   e   x���K
�  ��x�^@���,݄�H@0�)��%7�{R`���?�p�z�s��y��wE�����G&����*b�	Ul�$�:0�F�(�`�ںJ�j��3�~O�'�      �      x������ � �      �      x������ � �      �   ~   x��λ�0@�ڞ�l��_<MD$)"�0�z
�Y�b`������:Fo���m���9� @y�������*��]%�Lj?$!%�Ack�ٍ�,�_6���!��T��!ڄ���M�c�'��On      �      x������ � �      �   �   x�=�;�0 ��=�/@�h'�`A���%���u���7��C�\h�(4�eKu[֪�Mc*8a�o���x�n�S�����!ؽG�S�=�/��Ҁ���6�(W�Rp��A��`/�[a��z�5��<�NFR
m�{�dNmID�#x�}�\�Wa�eg�e��;�      �   �  x����n�@�g�)�yq[v�"[a cP���N���Sy<�}��@���!��J*vl�hO�N���ϟ��3R'����ppB��BI�[F��P��:�!8�? �I��:�.�!e���f80v�_��q^��d�0�Ƹͬ���\�-˻�������|�^=������<)�/>�~l�=����5����:Q&2F����F�qA3���`����2B��� ������1]�#�+��%U-��Ū��n�(@���k/�QOc���`�	�M�pƤ|7e{6�s�.n:���9M]��w���G��-��b���֜R<��W�:�\�L)=�[�#K;o�v6c=�]���N��b��^Y+&�WŤט��FA��Ps�3u^}�"�+��'�}Au�d�~�kp5�,�l�y(>��/�۪+ӘI�
7T�����8tǓNk��h�QF�;%��a·�����|��/��d�@�gH      �   �   x�}�M�0 �������PCO!BPV�P1u���VN�~}:w{y^j�@� ����P~�.�]ݾ)��
��!��嵭;Ê���/7�^�W��'��K^��<��'� �8����8%$��O�����)� �Z����\�6!��d��m`��7�w���8ܠ:�     