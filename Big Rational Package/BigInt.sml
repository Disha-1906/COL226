signature BIGINT=
    sig 
        type bigint=string
        exception bigint_error
        val sign : bigint -> Int.int 
        val sameSign : bigint * bigint -> bool
        val negate : bigint -> bigint
        val greater_than : bigint * bigint -> bool
        val greater_eq : bigint * bigint -> bool
        val equal_bigint : bigint * bigint -> bool
        val less_eq : bigint * bigint -> bool
        val less_than : bigint * bigint -> bool
        val add_bigint : bigint * bigint -> bigint
        val sub_bigint : bigint * bigint -> bigint
        val multiply_bigint : bigint * bigint -> bigint
        val division : bigint * bigint -> bigint
        val remainder : bigint * bigint -> bigint
end;
structure Bigint : BIGINT =struct
    type bigint=string
    exception bigint_error
    fun rem_zero_helper(s,i)=    
        if String.size(s)= 0
        then
            "0"
        else if String.substring(s,i,1) <> "0"
        then
            s
        else
            rem_zero_helper(String.substring(s,i+1,String.size(s)-1),i)
    fun rem_zero(s1) =
        if String.substring(s1,0,1) = "~" then let val x = String.extract(s1,1,NONE) in "~" ^ rem_zero_helper(x,0) end
        else rem_zero_helper(s1,0) 


    fun sign(x1) = 
        let val x= rem_zero(x1) 
        in    if String.substring(x,0,1) = "~" then ~1
            else if x = "0" then 0
            else 1
        end

    fun sameSign(x,y) = 
        let val s_1= sign(x)
            val s_2= sign(y)
        in if s_1 = s_2 orelse s_1 = 0 orelse s_2 = 0 then true else false
        end

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

    fun negate(s) = 
        if String.substring(s,0,1) = "~" then String.extract(s,1,NONE)
        else "~"^s

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

    fun compare_final(t,num1_h,num2_h)=
        let
            val num1=List.nth(equal_len_final(num1_h,num2_h),0)
            val num2=List.nth(equal_len_final(num1_h,num2_h),1)
        in
            compare(t,num1,num2,0)
        end

    fun greater_than(n1,n2) = 
        let val si_1 = sign(n1)
            val si_2 = sign(n2)
        in 
            if (si_1 = 0 orelse si_1 = 1) andalso (si_2 = 0 orelse si_2 = 1) then compare_final(2,n1,n2)
            else if si_1= ~1 andalso si_2= ~1 then not(compare_final(2,String.extract(n1,1,NONE),String.extract(n2,1,NONE)))
            else if si_1= ~1 then false
            else true
        end

    fun greater_eq(n1,n2) = 
        let val si_1 = sign(n1)
            val si_2 = sign(n2)
        in 
            if (si_1 = 0 orelse si_1 = 1) andalso (si_2 = 0 orelse si_2 = 1) then compare_final(1,n1,n2)
            else if si_1= ~1 andalso si_2= ~1 then not(compare_final(1,String.extract(n1,1,NONE),String.extract(n2,1,NONE)))
            else if si_1= ~1 then false
            else true
        end

    fun less_than(s1,s2) = not(greater_eq(s1,s2))
    fun less_eq(s1,s2) = not(greater_than(s1,s2))
    fun equal_bigint(s1,s2) = if greater_than(s1,s2) = false andalso greater_eq(s1,s2) = true then true else false
    fun add_helper(num1_h,num2_h,c,i,sum)=
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
                                add_helper(num1,num2,next_c,i-1,Int.toString(sum_p)^sum)
                            end
                        else
                            let 
                                val SOME op_1= Int.fromString(String.substring(num1,i,1));
                                val SOME op_2= Int.fromString(String.substring(num2,i,1));
                                val sum_p= op_1+op_2+c;
                                val next_c= sum_p div 10;
                                val next_s= Int.toString(sum_p mod 10)
                            in 
                                add_helper(num1,num2,next_c,i-1,next_s^sum)
                            end
        end
    fun sub_helper(num1_h,num2_h,c,i,diff)=
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
                    sub_helper(num1,num2,new_c,i-1,diff_f^diff)
                end
        end
    fun max_len(n1,n2) = 
        if String.size(rem_zero(n1)) > String.size(rem_zero(n2)) then String.size(rem_zero(n1)) else String.size(rem_zero(n2))
    fun add_bigint(n1,n2) = 
        let val sign_1=sign(n1)
            val sign_2=sign(n2)
        in
            if (sign_1= 0 orelse sign_1= 1) andalso (sign_2 = 0 orelse sign_2=1) then rem_zero(add_helper(rem_zero(n1),rem_zero(n2),0,max_len(n1,n2)-1,""))
            else if sign_1= ~1 andalso sign_2 = ~1 then "~" ^ rem_zero(add_helper(rem_zero(negate(n1)),rem_zero(negate(n2)),0,max_len(negate(n1),negate(n2))-1,""))
            else if sign_1 = ~1 then 
                    if greater_than(negate(n1),n2)= true then "~" ^ rem_zero(sub_helper(rem_zero(negate(n1)),rem_zero(n2),1,max_len(negate(n1),n2)-1,""))
                    else rem_zero(sub_helper(rem_zero(n2),rem_zero(negate(n1)),1,max_len(negate(n1),n2)-1,""))
            else 
                if greater_than(negate(n2),n1) = true then "~" ^ rem_zero(sub_helper(rem_zero(negate(n2)),rem_zero(n1),1,max_len(n1,negate(n2))-1,""))
                else rem_zero(sub_helper(rem_zero(n1),rem_zero(negate(n2)),1,max_len(n1,negate(n2))-1,""))     
        end 
    fun sub_bigint(n1,n2)=
        let val sign_1=sign(n1)
            val sign_2=sign(n2)
        in
            if (sign_1= 0 orelse sign_1= 1) andalso (sign_2 = 0 orelse sign_2=1) then
                if (greater_than(n1,n2)=true orelse equal_bigint(n1,n2)=true) then rem_zero(sub_helper(rem_zero(n1),rem_zero(n2),1,max_len(n1,n2)-1,"")) 
                else let val d = rem_zero(sub_helper(rem_zero(n2),rem_zero(n1),1,max_len(n1,n2)-1,"")) in "~"^d end           
            else if sign_1= ~1 andalso sign_2 = ~1 then
                if greater_than(negate(n1),negate(n2))=true then "~" ^ rem_zero(sub_helper(rem_zero(negate(n1)),rem_zero(negate(n2)),1,max_len(negate(n1),negate(n2))-1,""))
                else rem_zero(sub_helper(rem_zero(negate(n2)),rem_zero(negate(n1)),1,max_len(negate(n1),negate(n2))-1,"")) 
            else if sign_1 = ~1 then "~"^rem_zero(add_helper(rem_zero(negate(n1)),rem_zero(n2),0,max_len(negate(n1),n2)-1,""))           
            else rem_zero(add_helper(rem_zero(n1),rem_zero(negate(n2)),0,max_len(n1,negate(n2))-1,""))    
        end
    fun single_multi(num1,num2,c,i,prod)=
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
                single_multi(num1,num2,next_c,i-1,Int.toString(prod_hf)^prod)
            else
                single_multi(num1,num2,next_c,i-1,new_prod^prod)
        end
    fun multi_10x(num,x)=
        if x=0 then num
        else multi_10x(num^"0",x-1)

    fun many_multi(num1,num2,i,sum)=
        if i= ~1 then sum
        else 
            let 
                val p = String.substring(num2,i,1)
                val partial_product=single_multi(num1,p,0,String.size(num1)-1,"") 
                val new_num1=multi_10x(num1,1)
                val new_sum=add_bigint(sum,partial_product)

            in
                many_multi(new_num1,num2,i-1,new_sum)
            end
    fun multiply_bigint(num1,num2)=
        if sign(rem_zero(num1))=0 orelse sign(rem_zero(num2))=0 then "0"
        else
        let val g=sameSign(num1,num2) 
        in 
            if g=true then
                if sign(num1)= ~1 andalso sign(num2)= ~1 then rem_zero(many_multi(negate(num1),negate(num2),String.size(num2)-2,"0"))
                else rem_zero(many_multi(num1,num2,String.size(num2)-1,"0"))
            else if sign(num1)= ~1 then rem_zero(negate(many_multi(negate(num1),num2,String.size(num2)-1,"0")))
            else rem_zero(negate(many_multi(num1,negate(num2),String.size(num2)-2,"0")))
        end
    fun quo_digit(num1,num2,i)=
            let val prod=multiply_bigint(num2,Int.toString(i)) in 
            if greater_than(prod,num1)=true then i-1
            else if equal_bigint(prod,num1) = true then i
            else quo_digit(num1,num2,i+1) end

    fun division_helper(num1,num2,q,d,i)=
        if less_than(num1,num2) then ("0",rem_zero(num1))
        else if i= String.size(num1) then (rem_zero(q),rem_zero(d))
        else
            if i=0 then
                let val new_div = String.substring(num1,0,String.size(num2))
                in  if greater_eq(new_div,num2) then division_helper(num1,num2,q^Int.toString(quo_digit(new_div,num2,0)),sub_bigint(new_div,multiply_bigint(num2,Int.toString(quo_digit(new_div,num2,0)))),String.size(num2))
                    else let val qu=quo_digit(new_div^String.substring(num1,String.size(num2),1),num2,0)
                            val diff = sub_bigint(new_div^String.substring(num1,String.size(num2),1),multiply_bigint(num2,Int.toString(qu)))                        
                            in division_helper(num1,num2,q^Int.toString(qu),diff,String.size(num2)+1)
                        end
                end
            else
                let val new_div = d^String.substring(num1,i,1)
                    val qu=quo_digit(new_div,num2,0) 
                    val diff = sub_bigint(rem_zero(new_div),multiply_bigint(num2,Int.toString(qu))) 
                in division_helper(num1,num2,q^Int.toString(qu),diff,i+1)
                end
    fun division(num1,num2)=
        let val sign_1 = sign(num1)
            val sign_2 = sign(num2)
        in
            if sign_2 = 0 then ""
            else if sign_1=0 then "0"
            else if (sign_1= 1) andalso (sign_2=1) then let val quo = division_helper(rem_zero(num1),rem_zero(num2),"","0",0) in #1(quo) end
            else if sign_1= ~1 andalso sign_2 = ~1 then let val quo = division_helper(negate(rem_zero(num1)),negate(rem_zero(num2)),"","0",0) in #1(quo) end
            else if sign_1 = ~1 then let val quo = division_helper(negate(rem_zero(num1)),rem_zero(num2),"","0",0) in "~" ^ #1(quo) end
            else let val quo = division_helper(rem_zero(num1),negate(rem_zero(num2)),"","0",0) in "~" ^ #1(quo) end
        end 

    fun remainder(num1,num2)=
    let val sign_1 = sign(num1)
        val sign_2 = sign(num2)
    in
        if sign_2 = 0 then ""
        else if sign_1=0 then "0"
        else if sign_1= 1 andalso sign_2=1 then let val quo = division_helper(num1,num2,"","0",0) in #2(quo) end
        else if sign_1= ~1 andalso sign_2 = ~1 then let val quo = division_helper(negate(num1),negate(num2),"","0",0) in "~" ^ #2(quo) end 
        else if sign_1 = ~1 then let val quo = division_helper(negate(num1),num2,"","0",0) in rem_zero(sub_bigint(num2,#2(quo))) end
        else let val quo = division_helper(num1,negate(num2),"","0",0) in "~" ^ rem_zero(sub_bigint(negate(num2),#2(quo))) end
    end
end; 
open Bigint
functor RAT(X : BIGINT):
sig 
    type rational = bigint * bigint
    exception rat_error
    val make_rat: bigint * bigint -> rational option
    val rat: bigint -> rational option
    val reci: bigint -> rational option
    val neg: rational -> rational
    val inverse : rational -> rational option
    val equal : rational * rational -> bool (* equality *)
    val less : rational * rational -> bool (* less than *)
    val add : rational * rational -> rational (* addition *)
    val subtract : rational * rational -> rational (* subtraction *)
    val multiply : rational * rational -> rational (* multiplication *)
    val divide : rational * rational -> rational option (* division *)
    val showRat : rational -> string
    val showDecimal : rational -> string
    val fromDecimal : string -> rational
    val toDecimal : rational -> string
end=struct 
type rational = bigint * bigint
    exception rat_error
    fun rem_zero_helper(s,i)=    
        if String.size(s)= 0
        then
            "0"
        else if String.substring(s,i,1) <> "0"
        then
            s
        else
            rem_zero_helper(String.substring(s,i+1,String.size(s)-1),i)
    fun rem_zero(s1) =
        if String.substring(s1,0,1) = "~" then let val x = String.extract(s1,1,NONE) in "~" ^ rem_zero_helper(x,0) end
        else rem_zero_helper(s1,0) 
    fun gcd(n1,n2)= if equal_bigint(rem_zero(n2),"0") then n1 else gcd(rem_zero(n2),remainder(n1,n2))
    fun multi_10x(num,x)=
        if x=0 then num
        else multi_10x(num^"0",x-1)

    fun make_rat_copy(p1,p2)=
        let val sign1=sign(p1)
            val sign2=sign(p2)
        in  if sign2=0 then ("","")
            else if (sign1=0 orelse sign1=1) andalso sign2=1 then (division(p1,gcd(p1,p2)),division(p2,gcd(p1,p2)))
            else if  sign1= ~1 andalso sign2 = ~1 then (division(negate(p1),gcd(negate(p1),negate(p2))),division(negate(p2),gcd(negate(p1),negate(p2))))
            else if sign1 = ~1 then ("~" ^ division(negate(p1),gcd(negate(p1),p2)),division(p2,gcd(negate(p1),p2)))
            else 
                if division(p1,gcd(p1,negate(p2)))="0" then (division(p1,gcd(p1,negate(p2))),division(negate(p2),gcd(p1,negate(p2))))
                else  ("~" ^ division(p1,gcd(p1,negate(p2))),division(negate(p2),gcd(p1,negate(p2))))
        end

    fun make_rat(p1,p2)=
        let val sign1=sign(p1)
            val sign2=sign(p2)
        in  if sign2=0 then raise rat_error
            else if (sign1=0 orelse sign1=1) andalso sign2=1 then SOME (division(p1,gcd(p1,p2)),division(p2,gcd(p1,p2)))
            else if  sign1= ~1 andalso sign2 = ~1 then SOME (division(negate(p1),gcd(negate(p1),negate(p2))),division(negate(p2),gcd(negate(p1),negate(p2))))
            else if sign1 = ~1 then SOME ("~" ^ division(negate(p1),gcd(negate(p1),p2)),division(p2,gcd(negate(p1),p2)))
            else 
                if division(p1,gcd(p1,negate(p2)))="0" then SOME (division(p1,gcd(p1,negate(p2))),division(negate(p2),gcd(p1,negate(p2))))
                else  SOME ("~" ^ division(p1,gcd(p1,negate(p2))),division(negate(p2),gcd(p1,negate(p2))))
        end
        handle rat_error=>NONE

    fun rat(p)= SOME (p,"1")
    fun reci(p)=
        if rem_zero(p)="0" then raise rat_error
        else if sign(p)=1 then SOME ("1",p)
        else SOME ("~1",negate(p))
        handle rat_error=>NONE
    fun neg((p,q))=
        let val (v1,v2)=make_rat_copy(p,q) in
            if sign(v1)=1 orelse sign(v1)=0 then (negate(v1),v2)
            else (negate(v1),v2)
        end
    fun inverse_copy((p,q))=
        let val (p1,p2)= make_rat_copy(p,q) 
        in  if rem_zero(p)="0" then ("","")
            else if sign(p1)= ~1 then (negate(p2),negate(p1))
            else (p2,p1)
        end
    fun inverse((p,q))=
        let val (p1,p2)= make_rat_copy(p,q) 
        in  if rem_zero(p)="0" then raise rat_error
            else if sign(p1)= ~1 then SOME (negate(p2),negate(p1))
            else SOME (p2,p1)
        end
        handle rat_error=>NONE
    fun equal((p1,q1),(p2,q2)) = if make_rat_copy(p1,q1) = make_rat_copy(p2,q2) then true else false
    fun lcm(p,q) = division(multiply_bigint(p,q),gcd(p,q))
    fun less((p1,q1),(p2,q2)) = 
        let val (n1,n2) = make_rat_copy(p1,q1)
            val (m1,m2) = make_rat_copy(p2,q2)
        in less_than(multiply_bigint(n1,division(lcm(n2,m2),n2)),multiply_bigint(m1,division(lcm(n2,m2),m2)))
        end
    fun make_like((p1,q1),(p2,q2))=
        let val (n1,n2) = make_rat_copy(p1,q1)
            val (m1,m2) = make_rat_copy(p2,q2)
        in ((multiply_bigint(n1,division(lcm(n2,m2),n2)),lcm(n2,m2)),(multiply_bigint(m1,division(lcm(n2,m2),m2)),lcm(n2,m2)))
        end

    fun add((p1,q1),(p2,q2)) = let val ((m1,d1),(n1,d2)) = make_like((p1,q1),(p2,q2)) in  make_rat_copy(add_bigint(m1,n1),d1) end
    fun subtract((p1,q1),(p2,q2)) = let val ((m1,d1),(n1,d2)) = make_like((p1,q1),(p2,q2)) in  make_rat_copy(sub_bigint(m1,n1),d1) end
    fun multiply((p1,q1),(p2,q2))= make_rat_copy(multiply_bigint(p1,p2),multiply_bigint(q1,q2))
    fun divide((p1,q1),(p2,q2))= let val (m1,m2)=inverse_copy((p2,q2)) in if (m1,m2)=("","") then raise rat_error else SOME (multiply((m1,m2),(p1,q1))) end handle rat_error=>NONE
    fun showRat((p,q)) = #1(make_rat_copy(p,q)) ^ "/" ^ #2(make_rat_copy(p,q))
    fun helper_1(s1,c1,c2,p,i,f1,f2,sub1,sub2,sub3,sign) = 
        if i = 0 andalso String.substring(s1,0,1) = "~" then helper_1(s1,c1,c2,p,i+1,f1,f2,sub1,sub2,sub3,0)
        else if i =0 andalso String.substring(s1,0,1) = "+" then helper_1(s1,c1,c2,p,i+1,f1,f2,sub1,sub2,sub3,1)
        else if String.substring(s1,i,1) = ")" then [sub1,Int.toString(p),Int.toString(c1),sub2,Int.toString(c2),sub3,Int.toString(sign)]
        else if String.substring(s1,i,1) = "." then helper_1(s1,c1,c2,i,i+1,true,f2,sub1,sub2,sub3,sign)
        else if String.substring(s1,i,1) = "(" then helper_1(s1,c1,c2,p,i+1,false,true,sub1,sub2,sub3,sign)
        else if f1 = true then let val new_2 = sub2^String.substring(s1,i,1) in helper_1(s1,c1+1,c2,p,i+1,f1,f2,sub1,new_2,sub3,sign) end
        else if f2 = true then let val new_3 = sub3^String.substring(s1,i,1) in helper_1(s1,c1,c2+1,p,i+1,f1,f2,sub1,sub2,new_3,sign) end
        else let val new_1 = sub1^String.substring(s1,i,1) in helper_1(s1,c1,c2,p,i+1,f1,f2,new_1,sub2,sub3,sign) end

    fun fromDecimal(n) = 
        let val l = helper_1(n,0,0,0,0,false,false,"","","",1) in 
            if rem_zero(List.nth(l,5))="0" then 
                let val s1 = List.nth(l,0) 
                    val s2 = List.nth(l,3)
                    val SOME x = Int.fromString(List.nth(l,2))
                in if List.nth(l,6)="0" then neg((make_rat_copy(s1^s2,multi_10x("1",x)))) else make_rat_copy(s1^s2,multi_10x("1",x))
                end 
            else let val s1 = List.nth(l,0) ^ List.nth(l,3)
                    val s2 = s1 ^ List.nth(l,5)
                    val n = sub_bigint(s2,s1)
                    val SOME c1 = Int.fromString(List.nth(l,2))
                    val SOME c2 = Int.fromString(List.nth(l,4))
                    val d = sub_bigint(multi_10x("1",c1+c2),multi_10x("1",c1))
                in if List.nth(l,6)="0" then neg((make_rat_copy(n,d))) else make_rat_copy(n,d)             
                end
        end
    fun find(l,s,i) = 
        if List.nth(l,i) = s then i else find(l,s,i+1)

    fun helper2(n,l,q)=
        if remainder(#1(n),#2(n)) = "0" then 
            if sign(#1(n)) = 0 then "(0)" else  q^division(#1(n),#2(n)) ^ "(0)"
        else if List.exists(fn m => m = remainder(#1(n),#2(n))) l then
            let val i = find(l,remainder(#1(n),#2(n)),0) in String.substring(q^division(#1(n),#2(n)),0,i) ^ "(" ^ String.extract(q^division(#1(n),#2(n)),i,NONE) ^ ")" end
        else helper2((remainder(#1(n),#2(n)) ^ "0", #2(n)),l@[remainder(#1(n),#2(n))],q^division(#1(n),#2(n))) 
    fun toDecimal((n1,n2))=
        let val (m1,m2) = make_rat_copy(n1,n2) in 
            if sign(m1) = 0 then "0.(0)"
            else if sign(m1) = 1 then division(m1,m2) ^ "." ^ helper2((remainder(m1,m2) ^ "0" , m2),[remainder(m1,m2)],"")
            else "~" ^ division(negate(m1),m2) ^  "." ^ helper2((remainder(negate(m1),m2) ^ "0" , m2),[remainder(negate(m1),m2)],"")
            end
    fun showDecimal(n) = toDecimal(n)
end;
structure Rational = RAT(Bigint)
open Rational