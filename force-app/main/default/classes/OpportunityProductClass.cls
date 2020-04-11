public class OpportunityProductClass {
    
    public static void updateProductonOpp (Set<Id> oppIds,Boolean IsInsert,Boolean IsDelete){
        
        List<Opportunity> opp_to_update = new List<Opportunity>();
        Map<Id, List<OpportunityLineItem>> oppToOppLineItems = new Map<Id,List<OpportunityLineItem>>();
        Map<Id,Set<String>> oppToProdName = new Map<Id,Set<String>>();
        Map<Id,String> prodMap = new Map<Id,String>();
        Map<Id,Opportunity> fullMap = new Map<Id,Opportunity>();
        for(Opportunity opps :[Select id ,Products__c from Opportunity where ID IN:oppIds]){
            List<String> prodNameList = new List<String>();
            Set<String> prodName = new Set<String>();
            if(opps.Products__c!=null){
                prodNameList = opps.Products__c.split(';');
            }
            system.debug('Product Name List--->' + prodNameList);
            prodName.addAll(prodNameList);
            system.debug('Product Name Set--->' +prodName );
            oppToProdName.put(opps.Id,prodName);
            fullMap.put(opps.Id,opps);
            system.debug('Product Name Map --->' + oppToProdName);
            
        }
        for(OpportunityLineItem oli : [Select id ,Product2.Name,OpportunityId 
                                       FROM OpportunityLineItem where OpportunityId IN:oppIds]){
                                           if(IsInsert){
                                               String ProductName = !prodMap.containsKey(oli.OpportunityId) ?'' : prodMap.get(oli.OpportunityId);
                                               System.debug('ProductName1-->' + ProductName);
                                               if(oppToProdName.containsKey(oli.OpportunityId) 
                                                  && oppToProdName.get(oli.OpportunityId)!=null 
                                                  && !oppToProdName.get(oli.OpportunityId).isEmpty()){
                                                      Set<String> ExistProductName = oppToProdName.get(oli.OpportunityId);
                                                      if(!ExistProductName.contains(oli.Product2.Name)){
                                                          if(ProductName==''){
                                                              ProductName = oli.Product2.Name;
                                                          }else{
                                                              ProductName = ProductName + ';' + oli.Product2.Name;
                                                          }
                                                      }
                                                      system.debug('ProductName2---->' +  ProductName);
                                                      
                                                  }else{
                                                      if(ProductName ==''){
                                                          ProductName = oli.Product2.Name;
                                                      }else{
                                                          if(!ProductName.contains(oli.Product2.Name)){
                                                              ProductName = ProductName + ';'+oli.Product2.Name;
                                                          }
                                                      }
                                                      
                                                  }
                                               prodMap.put(oli.OpportunityId,ProductName);
                                               System.debug('--Opp with ProdMap---'+prodMap);
                                           }else{
                                               system.debug('id delete===='+oli.Id);
                                                   String ProductName = !prodMap.containsKey(oli.OpportunityId) ? '' : prodMap.get(oli.OpportunityId);
                                                   if(ProductName == ''){
													   ProductName = oli.Product2.Name;
                                                   }else{
													   ProductName = ProductName + ';' + oli.Product2.Name;
                                                   }
                                                   prodMap.put(oli.OpportunityId, ProductName);
                                               
                                           }
                                           
                                       }
        for(Id op_Id : oppToProdName.keySet()){
            if(IsInsert){
                if(prodMap.containsKey(op_Id) && !String.isEmpty(prodMap.get(op_Id))){
                Opportunity opppp = new Opportunity();
                opppp.Id = op_Id;
                String Test = '';
                if(oppToProdName.get(op_Id)!=null && !oppToProdName.get(op_Id).isEmpty()){
                    Test = fullMap.get(op_Id).Products__c + ';';
                }
                opppp.Products__c = Test + prodMap.get(op_Id);
                opp_to_update.add(opppp);
            }
            }else{
                if(oppToProdName.get(op_Id)!=null){
                    Opportunity opppp = new Opportunity();
                    opppp.Id = op_Id;
                    if(!prodMap.containsKey(op_Id)){
                        opppp.Products__c = '';
                        opp_to_update.add(opppp);
                        break;
                    }
                    else{
                        for(String s : oppToProdName.get(op_Id)){
                            if(!prodMap.get(op_Id).contains(s)){
                                opppp.Products__c = prodMap.get(op_Id);
                                opp_to_update.add(opppp);
                                break;
                            }
                        }
                    }
                    
                }
            }
            
        }
        if(opp_to_update != Null && !opp_to_update.isEmpty()) {
            update opp_to_update;
        }   
    }
}