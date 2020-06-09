(ns covidcare.rootroute
  (:require
    [compojure.core :refer :all]
    [covidcare.database :as db]
    [covidcare.view :as v]
    [ring.util.response :refer [redirect]]
    [clojure.spec.alpha :as s]
    [buddy.auth :refer [authenticated?]]))


(defn valid-email? [email] (re-matches #".+\@.+\..+" email))

(s/def ::string (s/and string? #(<= (count %) 20) #(>= (count %) 1)))
(s/def ::email (s/and string? valid-email?))

(defn login-submit [{{user :username pass :password :as params} :params session :session}]
  (if (or (nil? user) (nil? pass))
    (v/login "No username or password")
    (let [dbparams (if (nil? (valid-email? user)) {:username user :password pass} {:email user :password pass})
          userdata (first (db/get-user-by-params dbparams))]
      (if (empty? userdata)
        (v/login "Invalid username or password")
        (assoc (redirect "/schedules") :session (assoc session :identity userdata))))))


(defn register-submit [request]
  (let [ {:keys [firstname lastname username email picture password]} (:params request)
        error (cond-> ""
                (not (s/valid? ::string firstname)) (str "Invalid first name ") 
                (not (s/valid? ::string lastname)) (str "Invalid last name ")
                (not (s/valid? ::string username)) (str "Invalid user name ") 
                (not (s/valid? ::email email)) (str "Invalid email " )
                (not (s/valid? ::string password)) (str "Invalid password "))]
    (if (> (count error) 0)
      (v/register error (:params request))
      (do
        (db/add-user (assoc (:params request) :role "user"))
        (v/register "Registration successful" nil)))))


(defroutes root-routes
  (GET "/" {session :session :as request} (if (not (empty? session))
                                                   (v/schedules session) ; if user has session, go to shcedules
                                                   (v/login nil))) ; else request login
  (GET "/register" request (v/register nil nil))
  (POST "/" request (login-submit request))
  (POST "/register" request (register-submit request)))
