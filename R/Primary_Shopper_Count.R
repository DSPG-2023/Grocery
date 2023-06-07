#'
#'
#'
#'
#'

Primary_Shopper_Count<-function(pct_metro_prim=50,pct_rural_prim=30,
                                pct_town_prim=30){
  rural_pop<- Rural_Population()
  metro_pop<- City_populations()
  town_pop<- City_populations()
  (metro_pop*(pct_metro_prim/100))+
    (rural_pop*(pct_rural_prim/100))+(town_pop*(pct_town_prim/100))
}

Primary_Shopper_Count()
