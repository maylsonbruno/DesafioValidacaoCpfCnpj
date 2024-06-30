/**
 * @author maylsonbruno
 */

public virtual class AccountCpfValidator {
    
    public static Boolean validatorCPF(String cpf) {
       
        cpf = cpf.replaceAll('[^0-9]', '');

       
        if (cpf.length() != 11) {
            return false;
        }

       
        String[] invalids = new String[] {
            '00000000000', '11111111111', '22222222222', '33333333333', 
            '44444444444', '55555555555', '66666666666', '77777777777', 
            '88888888888', '99999999999'
        };
        for (String invalid : invalids) {
            if (cpf == invalid) {
                return false;
            }
        }

        
        Integer sum = 0;
        for (Integer i = 0; i < 9; i++) {
            sum += Integer.valueOf(cpf.substring(i, i + 1)) * (10 - i);
        }
        Integer firstCheck = 11 - (Math.mod(sum,11));
        if (firstCheck >= 10) {
            firstCheck = 0;
        }

        
        sum = 0;
        for (Integer i = 0; i < 10; i++) {
            sum += Integer.valueOf(cpf.substring(i, i + 1)) * (11 - i);
        }
        Integer secondCheck = 11 - (Math.mod(sum,11));
        if (secondCheck >= 10) {
            secondCheck = 0;
        }

       
        return firstCheck == Integer.valueOf(cpf.substring(9, 10)) && 
               secondCheck == Integer.valueOf(cpf.substring(10, 11));
    }
}