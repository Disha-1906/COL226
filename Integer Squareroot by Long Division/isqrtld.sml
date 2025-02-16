(* ---------------------------------------------------HELPER FUNCTIONS----------------------------------------------- *)

(* This function takes a string as input along with the current and required length and returns the string of required length *)
fun equal_len(num,req,curr)=
    if req=curr
    then
        num
    else
        let
            val new_num = "0"^num
        in
            equal_len(new_num,req-1,curr)
        end

(* This function takes two strings as arguments and returns both strings of length equal to the length of the larger string *)
fun equal_len_final(num1,num2)=
    let 
        val s1 = String.size(num1)
        val s2 = String.size(num2)
    in
        if s1>s2
        then
            [num1,equal_len(num2,s1,s2)]
        else 
            [equal_len(num1,s2,s1),num2]
    end

(* This function takes two strings as argument along with carry, index upto which the strings have been added and the value of the sum calculated till then. It firsts makes the two strings of equal length and then calculates the sum digit by digit by recursively calling itself. *)
fun add(num1_h,num2_h,c,i,sum)=
    let
        val num1=List.nth(equal_len_final(num1_h,num2_h),0)
        val num2=List.nth(equal_len_final(num1_h,num2_h),1)
    in
        if i= ~1
                then
                    sum
                else
                    if i=0
                    then
                        let 
                            val SOME op_1= Int.fromString(String.substring(num1,i,1));
                            val SOME op_2= Int.fromString(String.substring(num2,i,1));
                            val sum_p= (op_1+op_2+c);
                            val next_c= sum_p div 10
                        in 
                            add(num1,num2,next_c,i-1,Int.toString(sum_p)^sum)
                        end
                    else
                        let 
                            val SOME op_1= Int.fromString(String.substring(num1,i,1));
                            val SOME op_2= Int.fromString(String.substring(num2,i,1));
                            val sum_p= op_1+op_2+c;
                            val next_c= sum_p div 10;
                            val next_s= Int.toString(sum_p mod 10)
                        in 
                            add(num1,num2,next_c,i-1,next_s^sum)
                        end
    end

(* This function takes two strings as arguments along with the current carry, index upto which the product has been calculated and product calculated till then. It multiplies digit by digit and updates it arguments and recursively calls itself until the entire multiplicand is traversed completely and finally returns the product string *)
fun multi(num1,num2,c,i,prod)=
    if i= ~1
    then
        prod
    else
    let
        val SOME prod_h = Int.fromString(String.substring(num1,i,1));
        val SOME num2_f = Int.fromString(num2)
        val prod_hf = prod_h*num2_f +c;
        val next_c = prod_hf div 10;
        val new_prod = Int.toString(prod_hf mod 10)
    in
        if i=0
        then
            multi(num1,num2,next_c,i-1,Int.toString(prod_hf)^prod)
        else
            multi(num1,num2,next_c,i-1,new_prod^prod)
    end

(* This function takes a parameter t and the given number as string and depending on the value of t it concatenates either "00" or "0" when the value of t is 2 or 1 respectively, string analogue of multiplication by 100 or 10.*)
fun multi_10x(t,num)=
    case t of 
    1=> num^"0"
    |2=>num^"00";

(* This function takes two strings as arguments along with the carry , index upto which the string has been processed and the value of difference evaluated till then. Note that subtraction is carried out by additon of the 10's complement of the second string to the first string and discarding the carry. The 9's complement of the second string is found by subtracting each digit of the second string from 9. The calculation of 10's complement is guranteed by initialising carry to 1 when sub is first called. *)
fun sub(num1_h,num2_h,c,i,diff)=
    let 
        val num1=List.nth(equal_len_final(num1_h,num2_h),0)
        val num2=List.nth(equal_len_final(num1_h,num2_h),1)
    in
        if i= ~1
        then
            diff
        else
            let
                val SOME num2_f = Int.fromString(String.substring(num2,i,1))
                val new_num2 = 9 - num2_f
                val SOME num1_f = Int.fromString(String.substring(num1,i,1))
                val new_diff = num1_f+new_num2+c 
                val new_c = new_diff div 10
                val diff_f = Int.toString(new_diff mod 10)
            in 
                sub(num1,num2,new_c,i-1,diff_f^diff)
            end
    end

(* This function does two types comparison of strings of equal length, if t=1 it does greater than or equal to comparison and if t=2 it does greater than comparison and returns bool. Comparision is done digit by digit recursively calling itself unitl digit at which bith the strings differ is reached.  *)
fun compare(t,num1_h,num2_h,i)=
    let
        val num1=List.nth(equal_len_final(num1_h,num2_h),0)
        val num2=List.nth(equal_len_final(num1_h,num2_h),1)
    in
        if i= String.size(num1)
            then
                case t of
                1=>true
                |2=>false
        else
            let
                val SOME d1 = Int.fromString(String.substring(num1,i,1))
                val SOME d2 = Int.fromString(String.substring(num2,i,1))
            in
                if d1>d2
                then
                    true
                else if d1<d2
                then
                    false
                else
                    compare(t,num1,num2,i+1)
            end
    end

 (* This takes two unequal length strings as arguments and makes them of equal length and calls compare *)
fun compare_final(t,num1_h,num2_h)=
    let
        val num1=List.nth(equal_len_final(num1_h,num2_h),0)
        val num2=List.nth(equal_len_final(num1_h,num2_h),1)
    in
        compare(t,num1,num2,0)
    end

(* This function removes the unecessary extra zeroes at the left of the string *)
fun rem_zero(s,i,p)=
    if p= 0
    then
        "0"
    else if String.substring(s,i,1) <> "0"
    then
        s
    else
        rem_zero(String.substring(s,i+1,p-1),i,p-1)

(* This function concatenates two strings s1 and s2 *)
fun concat(s1,s2) = s1^s2

(* This function takes a string as an argument and if it is of odd length, it returns the string by concatenating 0 to the left. *)
fun make_str(s)=
    if (String.size(s)) mod 2 =1
    then
        concat("0",s)
    else
        s

(* This function takes string, list of pairs of digits of string and the index upto which the list has been processed. It traverses along the string and breaks its digits into pairs and appends them to the list and finaaly returns the list. *)
fun make_list(s,s_list,j)=
    if j=String.size(s)
    then 
        s_list
    else
        let
        val sub = String.substring(s,j,2)
        in
        make_list(s,s_list@[sub],j+2)
        end   

(* This function works similar to binary search and is used to find the next digit d of the quotient such that (10*num1 + d)*d is just less than num2 and closest possible. It takes two strings as arguments , the left and right indices which the bound the part of the list in which the digit has to be searched and the list containing the digits from 0 to 9. *)
fun find(num1,num2,l,r,arr)=
    let
        val m=(l+r) div 2
    in 
        if r-l=1
        then
        let
            val f_low = multi(add(multi_10x(1,num1),Int.toString(List.nth(arr,l)),0,String.size(multi_10x(1,num1))-1,""),Int.toString(List.nth(arr,l)),0,String.size(num1),"")
            val f_high = multi(add(multi_10x(1,num1),Int.toString(List.nth(arr,r)),0,String.size(multi_10x(1,num1))-1,""),Int.toString(List.nth(arr,r)),0,String.size(num1),"")
        in        
            if compare_final(1,num2,f_high) andalso compare_final(1,num2,f_low)
            then
                (Int.toString(List.nth(arr,r)),add(multi_10x(1,num1),Int.toString(List.nth(arr,r)),0,String.size(num1),""))
            else
                (Int.toString(List.nth(arr,l)),add(multi_10x(1,num1),Int.toString(List.nth(arr,l)),0,String.size(num1),""))
    end
        else if compare_final(2,num2,multi(add(multi_10x(1,num1),Int.toString(List.nth(arr,m)),0,String.size(multi_10x(1,num1))-1,""),Int.toString(List.nth(arr,m)),0,String.size(num1),""))
        then
            find(num1,num2,m,r,arr)
        else
            find(num1,num2,l,m,arr)
    end

(* --------------------------------------------------------MAIN FUNCTIONS------------------------------------------------------- *)

(* This function is the primary part of the code. It takes current dividend rem, current evaluated quotient quo, the current divisor n, the len of the s_list processed and the s_list. First, it calls the find function to get the next digit of the quotient, on getting it, it calculates new_dividend and new_quotient. After updating its arguments it recursively calls itself unitl s_list is traversed completely. *)
fun helper(rem,quo,n,len,s_list)=
    if len=List.length(s_list)+1
    then
        (rem,quo)
    else
        let
            val tup= find(n,rem,0,9,[0,1,2,3,4,5,6,7,8,9])
            val q = #1 tup
            val d = #2 tup
        in
            if len=List.length(s_list)
            then
                helper(sub(rem,multi(d,q,0,String.size(d)-1,""),1,String.size(rem)-1,""),add(multi_10x(1,quo),q,0,String.size(quo),""),add(d,q,0,String.size(d)-1,""),len+1,s_list)
            else
                let
                    val r = sub(rem,multi(d,q,0,String.size(d)-1,""),1,String.size(rem)-1,"")^(List.nth(s_list,len))
                in
                    helper(r,add(multi_10x(1,quo),q,0,String.size(quo),""),add(d,q,0,String.size(d)-1,""),len+1,s_list)
                end
        end

(* This is the main part of the code. It takes a number sting as an input, converts it to even length string and makes list containing the pairs of digits of the input string and after performing the necessary operations on the list returns a tuple containing the integer squareroot and the smallest number which should be subtracted from the input string to get a perfect square. *)
fun isqrtld(s)=
    let
        val s1 = make_str(s)
        val s2 = make_list(s1,[],0)
        val  x = (List.nth(s2,0))
        val (ans1,ans2)=helper(x,"","",1,s2)
    in
        (rem_zero(ans2,0,String.size(ans2)),rem_zero(ans1,0,String.size(ans1)))
    end
