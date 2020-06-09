(ns covidcare.database
  (:require [clojure.java.jdbc :as sql]
            [korma.core :as k]
            [korma.db :refer [defdb mysql]])
  (:import java.sql.DriverManager))

(def db-config(clojure.edn/read-string (slurp "database/migratus-conf.edn")))

(defdb db (mysql db-config))

(k/defentity user
             (k/table :user))

(k/defentity schedule
             (k/table :schedule))

(defn get-all-users[]
  (k/select user))

(defn get-all-schedules[]
  (k/select schedule))

(defn get-user-by-params [params]
  (k/select user (k/where params)))

(defn get-schedules-by-params [params]
  (k/select schedule (k/where params)))

(defn add-user [params]
  (k/insert user (k/values params)))

(defn delete-user [params]
  (k/delete user (k/where params)))

(defn update-user [params]
  (k/update user
            (k/set-fields params)
            (k/where {:userid (:userid params)})))

(defn add-schedule [params]
  (k/insert schedule (k/values params)))

(defn update-schedule [params]
  (k/update schedule
            (k/set-fields params)
            (k/where {:scheduleid (:scheduleid params)})))
