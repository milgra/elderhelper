(ns covidcare.mainroute
  (:require
    [compojure.core :refer :all]
    [covidcare.database :as db]
    [covidcare.view :as v]
    [clojure.spec.alpha :as s]
    [ring.util.response :refer [redirect]]))

(defn valid-date? [date] (re-matches #"(202[0-9])-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])" date))

(s/def ::string (s/and string? #(<= (count %) 20) #(>= (count %) 1)))
(s/def ::date (s/and string? valid-date?))

(defn reserve [session request]
  (let [scheduleid (get-in request [:params :scheduleid])
        userid (get-in session [:identity :userid])]
    (db/update-schedule {:scheduleid scheduleid :helpeeid userid})
    (v/schedules session)))


(defn applyfor [session request]
  (let [scheduleid (get-in request [:params :scheduleid])
        userid (get-in session [:identity :userid])]
    (db/update-schedule {:scheduleid scheduleid :userid userid})
    (v/schedules session)))


(defn addoffer [session request]
  (let [{:keys [fromdate todate city district service]} (:params request)
        error (cond-> ""
                (not (s/valid? ::date fromdate)) (str "Invalid from date ") 
                (not (s/valid? ::date todate)) (str "Invalid to date ")
                (not (s/valid? ::string city)) (str "Invalid city ") 
                (not (s/valid? ::string district)) (str "Invalid district " )
                (not (s/valid? ::string service)) (str "Invalid service "))]
    (if (> (count error) 0)
      (v/addoffer error (:params request))
      (let [userid (get-in session [:identity :userid])]
        (db/add-schedule (assoc (:params request) :userid userid))
        (v/offers session)))))
    

(defn addrequest [session request]
  (let [{:keys [fromdate todate city district service]} (:params request)
        error (cond-> ""
                (not (s/valid? ::date fromdate)) (str "Invalid from date ") 
                (not (s/valid? ::date todate)) (str "Invalid to date ")
                (not (s/valid? ::string city)) (str "Invalid city ") 
                (not (s/valid? ::string district)) (str "Invalid district " )
                (not (s/valid? ::string service)) (str "Invalid service "))]
    (if (> (count error) 0)
      (v/addrequest error (:params request))
      (let [userid (get-in session [:identity :userid])]
        (db/add-schedule (assoc (:params request) :userid userid))
        (v/requests session)))))


(defroutes main-routes
  (GET "/schedules" {session :session} (v/schedules session))
  (GET "/offers" {session :session} (v/offers session))
  (GET "/requests" {session :session} (v/requests session))
  (GET "/logout" request (assoc (redirect "/") :session {}))
  (GET "/addoffer"  {session :session} (v/addoffer "" nil))
  (GET "/addrequest"  {session :session} (v/addrequest "" nil))
  ;; api calls
  (GET "/reserve"  {session :session :as request} (reserve session request))
  (GET "/apply"  {session :session :as request} (applyfor session request))
  (POST "/addoffer" {session :session :as request} (addoffer session request))
  (POST "/addrequest" {session :session :as request} (addrequest session request)))
