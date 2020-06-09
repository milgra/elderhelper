(ns covidcare.adminroute
  (:require
    [compojure.core :refer :all]
    [covidcare.database :as db]
    [covidcare.view :as v]
    [clojure.spec.alpha :as s]
    [ring.util.response :refer [redirect]]))

(defn valid-email? [email] (re-matches #".+\@.+\..+" email))

(s/def ::string (s/and string? #(<= (count %) 20) #(>= (count %) 1)))
(s/def ::email (s/and string? valid-email?))
(s/def ::role #{"admin" "user"})

(defn removeuser [session request]
  (let [userid (get-in request [:params :userid])]
    (db/delete-user {:userid userid})
    (v/admin session)))


(defn adduser [session request]
  (let [{:keys [firstname lastname username email role picture password]} (:params request)
        error (cond-> ""
                (not (s/valid? ::string firstname)) (str "Invalid first name ") 
                (not (s/valid? ::string lastname)) (str "Invalid last name ")
                (not (s/valid? ::string username)) (str "Invalid user name ") 
                (not (s/valid? ::email email)) (str "Invalid email " )
                (not (s/valid? ::string password)) (str "Invalid password ")
                (not (s/valid? ::role role)) (str "Role must be user or admin"))]
    (if (> (count error) 0)
      (v/adduser error (:params request))
      (do
        (db/add-user (:params request))
        (v/adduser "User added/updated" nil)))))


(defn updateuser [session request]
  (let [{:keys [firstname lastname username email role picture password]} (:params request)
        error (cond-> ""
                (not (s/valid? ::string firstname)) (str "Invalid first name ") 
                (not (s/valid? ::string lastname)) (str "Invalid last name ")
                (not (s/valid? ::string username)) (str "Invalid user name ") 
                (not (s/valid? ::email email)) (str "Invalid email " )
                (not (s/valid? ::string password)) (str "Invalid password ")
                (not (s/valid? ::role role)) (str "Role must be user or admin"))]
    (if (> (count error) 0)
      (v/adduser error (:params request))
      (do
        (db/update-user (:params request))
        (v/adduser "User added/updated" nil)))))


(defroutes admin-routes
  (GET "/admin"  {session :session} (v/admin session))
  (GET "/adduser"  {session :session :as request} (v/adduser nil nil))
  (GET "/edituser"  {session :session :as request} (v/adduser nil (first (db/get-user-by-params (:params request)))))
  ;; api calls
  (GET "/removeuser"  {session :session :as request} (removeuser session request))
  (POST "/adduser" {session :session :as request} (adduser session request))
  (POST "/updateuser" {session :session :as request} (updateuser session request)))
