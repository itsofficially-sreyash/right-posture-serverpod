BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "coach_note" (
    "id" bigserial PRIMARY KEY,
    "shareId" bigint NOT NULL,
    "authorName" text NOT NULL,
    "message" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "readAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "coach_note_share_idx" ON "coach_note" USING btree ("shareId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "coach_share" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "code" text NOT NULL,
    "label" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revokedAt" timestamp without time zone,
    "viewCount" bigint NOT NULL DEFAULT 0,
    "lastViewedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "coach_share_code_idx" ON "coach_share" USING btree ("code");
CREATE INDEX "coach_share_owner_idx" ON "coach_share" USING btree ("authUserId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "coach_note"
    ADD CONSTRAINT "coach_note_fk_0"
    FOREIGN KEY("shareId")
    REFERENCES "coach_share"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR right_posture
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('right_posture', '20261014101047769', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014101047769', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
