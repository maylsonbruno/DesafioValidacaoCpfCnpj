/**
 * @author maylsonbruno
 */

public virtual class AccountCnpjValidator {
   
    public static Boolean validatorCNPJ(String cnpj) {
      
        cnpj = cnpj.replaceAll('[^0-9]', '');
  
        
        if (cnpj.length() != 14) {
            return false;
        }
  
        
        String[] invalids = new String[] {
            '00000000000000', '11111111111111', '22222222222222', '33333333333333', 
            '44444444444444', '55555555555555', '66666666666666', '77777777777777', 
            '88888888888888', '99999999999999'
        };
        for (String invalid : invalids) {
            if (cnpj == invalid) {
                return false;
            }
        }
  
        
        Integer[] weights1 = new Integer[] {5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2};
        Integer sum = 0;
        for (Integer i = 0; i < 12; i++) {
            sum += Integer.valueOf(cnpj.substring(i, i + 1)) * weights1[i];
        }
        Integer firstCheck = Math.mod(sum , 11);
        firstCheck = (firstCheck < 2) ? 0 : 11 - firstCheck;
  
        
        Integer[] weights2 = new Integer[] {6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2};
        sum = 0;
        for (Integer i = 0; i < 13; i++) {
            sum += Integer.valueOf(cnpj.substring(i, i + 1)) * weights2[i];
        }
        Integer secondCheck = Math.mod(sum , 11);
        secondCheck = (secondCheck < 2) ? 0 : 11 - secondCheck;
  
        
        return firstCheck == Integer.valueOf(cnpj.substring(12, 13)) && 
               secondCheck == Integer.valueOf(cnpj.substring(13, 14));
    }
}