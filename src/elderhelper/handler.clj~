(ns covidcare.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]            
            [buddy.auth.backends.session :refer [session-backend]]
            [buddy.auth.middleware :refer [wrap-authentication wrap-authorization]]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]
            [ring.middleware.json :refer [wrap-json-response]]
            [ring.util.response :refer [redirect]]
            [covidcare.rootroute :refer [root-routes]]
            [covidcare.mainroute :refer [main-routes]]
            [covidcare.adminroute :refer [admin-routes]]
            [covidcare.view :as v]
            [buddy.auth :refer [authenticated?]])
  (:use [clojure.pprint]))


(defroutes app-routes
  (route/resources "/")
  (route/not-found "Not Found"))


(defn wrap-must-be-authenticated [handler]
  (fn [request]
    (if (authenticated? request)
      (handler request)
      (assoc (redirect "/") :session {}))))

(defn wrap-must-be-admin [handler]
  (fn [request]
    (if (and (authenticated? request) (= "admin" (get-in request [:identity :role])))
      (handler request)
      (assoc (redirect "/") :session {}))))


(defn req-res-displayer [handler]
  (fn [req]
    (let [res (handler req)]
      (println "\nRequest:")
      (clojure.pprint/pprint req)
      (println "\nResponse:")
      (clojure.pprint/pprint res)
      res)))


(def backend (session-backend))


(def app
  (-> (routes root-routes (wrap-must-be-authenticated main-routes) (wrap-must-be-admin admin-routes)  app-routes)
      (wrap-json-response)
      ;;(req-res-displayer)
      (wrap-authentication backend)
      (wrap-authorization backend)
      (wrap-defaults (assoc-in site-defaults [:security :anti-forgery] false))))
