BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workout_record" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "clientId" text NOT NULL,
    "completedAt" timestamp without time zone NOT NULL,
    "note" text,
    "setCount" bigint NOT NULL,
    "totalReps" bigint NOT NULL,
    "averageFormScore" double precision,
    "payload" text NOT NULL,
    "uploadedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "workout_record_owner_client_idx" ON "workout_record" USING btree ("authUserId", "clientId");
CREATE INDEX "workout_record_owner_completed_idx" ON "workout_record" USING btree ("authUserId", "completedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workout_set_record" (
    "id" bigserial PRIMARY KEY,
    "workoutId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "exercise" text NOT NULL,
    "completedAt" timestamp without time zone NOT NULL,
    "totalReps" bigint NOT NULL,
    "goodReps" bigint NOT NULL,
    "warningReps" bigint NOT NULL,
    "degradedReps" bigint NOT NULL,
    "formScore" double precision,
    "consistencyScore" double precision,
    "degradationStartRep" bigint
);

-- Indexes
CREATE INDEX "workout_set_record_owner_exercise_idx" ON "workout_set_record" USING btree ("authUserId", "exercise", "completedAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "workout_set_record"
    ADD CONSTRAINT "workout_set_record_fk_0"
    FOREIGN KEY("workoutId")
    REFERENCES "workout_record"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR right_posture
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('right_posture', '20261014082350901', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014082350901', "timestamp" = now();

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
