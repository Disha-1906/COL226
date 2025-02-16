fun write_up(fil,stri)=
    let val outp = TextIO.openAppend fil
    in
        let val in_string = TextIO.output(outp,stri^" ")
        in
            TextIO.closeOut outp
        end
    end
fun write_to_file(l,i)= 
    if i=List.length(l) then write_up("filename.html","")
    else let val w1 = write_up("filename.html",List.nth(l,i))
         in write_to_file(l,i+1)
         end
fun symbol_counter(sym,s,i,c)=
    if i = String.size(s) then
        c 
    else if String.substring(s,i,1)=sym then symbol_counter(sym,s,i+1,c+1)
    else c
(* --------------------------------------------------BLOCKQUOTES---------------------------------------------------------- *)
fun blockquote_helper(c,s,text)=
    if c=0 then s
    else blockquote_helper(c-1,s^text,text)   
fun blockquote(l)=
        let val s1 = List.nth(l,0)
            val c = symbol_counter(">",s1,0,0)
            val s_begin = blockquote_helper(c,"","<blockquote>")
            val s_end = blockquote_helper(c,"","</blockquote>")
        in
            if c <> String.size(s1) then 
                let val s_rem = String.substring(s1,c,String.size(s1)-c) 
                    val l_final = [s_begin]@[s_rem]@tl(l)@[s_end]
                in l_final
                end
            else let val l_final = [s_begin]@tl(l)@[s_end]
                in l_final
                end
        end
(* -------------------------------------------------------------------------------------------------------------------------- *)
(* -----------------------------------------------------------HEADINGS------------------------------------------------------- *)
fun six_symbol_counter(sym,s,i,c)=
    if i = String.size(s)  then
        if c>6 then 6
        else c 
    else if String.substring(s,i,1)=sym then six_symbol_counter(sym,s,i+1,c+1)
    else 
        if c>6 then 6
        else c 
fun headings(l,i,s,flag_start,flag_end)=
    if i = List.length(l) then l 
    else let val s0= List.nth(l,i) in
        if String.isPrefix "#" s0 andalso flag_start = 0 then 
            let val c = six_symbol_counter("#",s0,0,0) in
                if i= List.length(l)-1 then 
                    let val s_rem = String.substring(s0,c,String.size(s0)-c)
                        val s_begin = "<h"^Int.toString(c)^">"
                        val s_end = "</h"^Int.toString(c)^">"
                        val (l_begin,l_end) = List.splitAt(l,i)
                        val l_final = l_begin@[s_begin^s_rem^s_end]@tl(l_end) 
                    in headings(l_final,i+1,s_end,1,1) end
                else if c<>String.size(s0) then
                    let val s_rem = String.substring(s0,c,String.size(s0)-c)
                        val s_begin = "<h"^Int.toString(c)^">"
                        val s_end = "</h"^Int.toString(c)^">"
                        val (l_begin,l_end) = List.splitAt(l,i)
                        val l_final = l_begin@[s_begin^s_rem]@tl(l_end)
                    in headings(l_final,i+1,s_end,1,0) end
                else let val s_begin = "<h"^Int.toString(c)^">"
                         val s_end = "</h"^Int.toString(c)^">"
                         val (l_begin,l_end) = List.splitAt(l,i)
                         val l_final = l_begin@[s_begin]@tl(l_end)
                    in headings(l_final,i+1,s_end,1,0) end 
            end 
        else if (s0 = "</blockquote>") andalso flag_end = 0 andalso flag_start=1 then 
            let val (l_begin,l_end) = List.splitAt(l,i)
                val l_final= l_begin@[s^s0]@tl(l_end)
            in headings(l_final,i+1,s,1,1) end
        else if i=List.length(l)-1 andalso flag_end = 0 andalso flag_start=1 then
            let val (l_begin,l_end) = List.splitAt(l,i)
                val l_final= l_begin@[s0^s]@tl(l_end)
            in headings(l_final,i+1,s,1,1) end
        else headings(l,i+1,s,flag_start,flag_end) end
(* -------------------------------------------------------------------------------------------------------------------------- *)
(* --------------------------------------------------BOLD-------------------------------------------------------------------- *)
fun find_index(letter,word,l,i)=
    if i = String.size(word)-1 then l
    else if String.substring(word,i,2)= letter then let val l1 = l@[i] in find_index(letter,word,l1,i+1) end
    else find_index(letter,word,l,i+1)
fun bold(l,i,flag)=
    if i = List.length(l) then l
    else 
        let val s1 = List.nth(l,i)
            val index_list = find_index("**",s1,[],0)
        in if String.isPrefix "**" s1 andalso String.isSuffix "**" s1 then
                let val s_rem = String.substring(s1,2,String.size(s1)-4)
                    val (l_begin,l_end) = List.splitAt(l,i)
                    val l_final = l_begin@["<strong>"]@[s_rem]@["</strong>"]@tl(l_end)
                in bold(l_final,i+1,flag) end
            else if List.length(index_list)=1 then 
                if String.isSubstring "**" s1 andalso flag = 0 then 
                    let val i1 = List.nth(index_list,0)
                        val s_begin = String.substring(s1,0,i1)
                        val s_end = String.substring(s1,i1+2,String.size(s1)-i1-2)
                        val s_final = s_begin^"<strong>"^s_end
                        val (l_begin,l_end) = List.splitAt(l,i)
                        val l_final = l_begin@[s_final]@tl(l_end)
                    in bold(l_final,i+1,1) end
                else if String.isSubstring "**" s1 andalso flag = 1 then 
                    let val i1 = List.nth(index_list,0)
                        val s_begin = String.substring(s1,0,i1)
                        val s_end = String.substring(s1,i1+2,String.size(s1)-i1-2)
                        val s_final = s_begin^"</strong>"^s_end
                        val (l_begin,l_end) = List.splitAt(l,i)
                        val l_final = l_begin@[s_final]@tl(l_end)
                    in bold(l_final,i+1,0) end  
                else bold(l,i+1,flag)  
            else if List.length(index_list)=2 then
                let val i1 = List.nth(index_list,0)
                    val i2 = List.nth(index_list,1)
                    val s_begin =  String.substring(s1,0,i1)
                    val s_mid = String.substring(s1,i1+2,i2-i1-2)
                    val s_end = String.substring(s1,i2+2,String.size(s1)-i2-2)
                    val s_final = s_begin^"<strong>"^s_mid^"</strong>"^s_end
                    val (l_begin,l_end) = List.splitAt(l,i)
                    val l_final = l_begin@[s_final]@tl(l_end)
                in bold(l_final,i+1,0) end 
            else bold(l,i+1,0) end

(* ---------------------------------------------------------------------------------------------------------------------------- *)
(* -----------------------------------------------------------ITALICS---------------------------------------------------------- *)
fun find_index_2(l_1,l_2,word,l,i)=
    if i = String.size(word)-1 andalso String.substring(word,i,1)="*" then l@[i]
    else if i = String.size(word)-1 orelse i= String.size(word) then l
    else if String.substring(word,i,1)= l_1 andalso (String.substring(word,i,2)= l_2) then find_index_2(l_1,l_2,word,l,i+2) 
    else if String.substring(word,i,1)= l_1 andalso not(String.substring(word,i,2)= l_2) then let val l1 = l@[i] in find_index_2(l_1,l_2,word,l1,i+1) end
    else find_index_2(l_1,l_2,word,l,i+1)
fun italics(l,i,flag)=
    if i = List.length(l) then l
    else 
        let val s1 = List.nth(l,i)
            val index_list = find_index_2("*","**",s1,[],0)
        in if String.isPrefix "*" s1 andalso String.isSuffix "*" s1 andalso not(String.isPrefix "**" s1) andalso not(String.isSuffix "**" s1) then
                let val s_rem = String.substring(s1,1,String.size(s1)-2)
                    val (l_begin,l_end) = List.splitAt(l,i)
                    val l_final = l_begin@["<em>"]@[s_rem]@["</em>"]@tl(l_end)
                in italics(l_final,i+1,flag)
                end
            else if List.length(index_list)=1 andalso flag = 0 then 
                    let val i1 = List.nth(index_list,0)
                        val s_begin = String.substring(s1,0,i1)
                        val s_end = String.substring(s1,i1+1,String.size(s1)-i1-1)
                        val s_final = s_begin^"<em>"^s_end
                        val (l_begin,l_end) = List.splitAt(l,i)
                        (* val l_final = l_begin@[s_final]@tl(l_end) *)
                        val l_final = List.update(l,i,s_final)
                in italics(l_final,i+1,1) end
            else if List.length(index_list)=1 andalso flag = 1 then
                    let val i1 = List.nth(index_list,0)
                        val s_begin = String.substring(s1,0,i1)
                        val s_end = String.substring(s1,i1+1,String.size(s1)-i1-1)
                        val s_final = s_begin^"</em>"^s_end
                        (* val (l_begin,l_end) = List.splitAt(l,i)
                        val l_final = l_begin@[s_final]@tl(l_end) *)
                        val l_final = List.update(l,i,s_final)
                in italics(l_final,i+1,0) end
            else if List.length(index_list)=2 then
                let val i1 = List.nth(index_list,0)
                    val i2 = List.nth(index_list,1)
                    val s_begin =  String.substring(s1,0,i1)
                    val s_mid = String.substring(s1,i1+1,i2-i1-1)
                    val s_end = String.substring(s1,i2+1,String.size(s1)-i2-1)
                    val s_final = s_begin^"<em>"^s_mid^"</em>"^s_end
                    val (l_begin,l_end) = List.splitAt(l,i)
                    val l_final = l_begin@[s_final]@tl(l_end)
                in italics(l_final,i+1,flag) end 
            else italics(l,i+1,flag)
        end

(* -------------------------------------------------------------------------------------------------------------------------------- *)
(* ---------------------------------------------------UNDERLINE-------------------------------------------------------------------- *)
fun underline(l,i)=
    if i  = List.length(l) then l
    else 
        let val s1 = List.nth(l,i)
        in if String.isPrefix "_" s1 andalso String.isSuffix "_" s1 then
                let val s_rem_i = String.substring(s1,1,String.size(s1)-2)
                    val s_list = String.tokens(fn c=> c = #"_") s_rem_i
                    val s_rem = String.concatWith " " s_list
                    val (l_begin,l_end) = List.splitAt(l,i)
                    val l_final = l_begin@["<u>"]@[s_rem]@["</u>"]@tl(l_end)
                in underline(l_final,i+1)
                end
            else underline(l,i+1)
        end
(* ----------------------------------------------------------------------------------------------------------------------------------- *)
(* ----------------------------------------------------HORIZONTAL RULE---------------------------------------------------------------- *)
fun horizontal_rule(l)=
    if l = ["---\n"] then 
        let val l_final = ["<hr />\n"]
        in l_final end
    else l
(* -----------------------------------------------implement list befor rule---------------------------------------------------------- *)
(* --------------------------------------------------UNORDERED LISTS----------------------------------------------------------------- *)
fun unordered_list(nested_list,i,flag)=
    if i = List.length(nested_list) andalso flag = 1 then 
        let val l_final= nested_list@[["</ul>"]] in l_final end
    else if i = List.length(nested_list) then nested_list
    else let val l = List.nth(nested_list,i)
             val s = List.nth(l,0)
        in
            if String.substring(s,0,1)="-" andalso flag = 0  then
                let val l_final = ["<ul><li>"]@tl(l)@["</li>"]
                    val nested_list_final = List.update(nested_list,i,l_final)
                in unordered_list(nested_list_final,i+1,1) end
            else if flag = 1 andalso not(String.substring(s,0,1)="-") then
                let val l_final = ["</ul>"]@l
                    val nested_list_final = List.update(nested_list,i,l_final) 
                in unordered_list(nested_list_final,i+1,0) end
            else if flag =1 then
                let val l_final = ["<li>"]@tl(l)@["</li>"]
                    val nested_list_final = List.update(nested_list,i,l_final) 
                in unordered_list(nested_list_final,i+1,1) end 
            else unordered_list(nested_list,i+1,flag)
        end
(* ---------------------------------------------------------------------------------------------------------------------------------- *)
(* --------------------------------------------------ORDERED LISTS------------------------------------------------------------------- *)
fun digit_checker(s,i)=
    if i = String.size(s) then true
    else let val s0 = String.sub(s,i) in
        if Char.isDigit(s0) then digit_checker(s,i+1)
        else false end
    
fun ordered_list(nested_list,i,flag)=
    if i = List.length(nested_list) andalso flag = 1 then 
        let val l_final= nested_list@[["</ol>"]] in l_final end
    else if i = List.length(nested_list) then nested_list
    else let val l = List.nth(nested_list,i)
             val s = List.nth(l,0)
        in
            if digit_checker(String.substring(s,0,String.size(s)-1),0) andalso String.substring(s,String.size(s)-1,1)="." andalso flag = 0  then
                let val l_final = ["<ol><li>"]@tl(l)@["</li>"]
                    val nested_list_final = List.update(nested_list,i,l_final)
                in ordered_list(nested_list_final,i+1,1) end
            else if flag = 1 andalso not(digit_checker(String.substring(s,0,String.size(s)-1),0)) then
                let val l_final = ["</ol>"]@l
                    val nested_list_final = List.update(nested_list,i,l_final) 
                in ordered_list(nested_list_final,i+1,0) end
            else if flag =1 then
                let val l_final = ["<li>"]@tl(l)@["</li>"]
                    val nested_list_final = List.update(nested_list,i,l_final) 
                in ordered_list(nested_list_final,i+1,1) end 
            else ordered_list(nested_list,i+1,flag)
        end   
(* --------------------------------------------------------------------------------------------------------------------------------------- *)
(* --------------------------------------------------------------TABLES------------------------------------------------------------------- *)
fun create_table(l,i)=
    if i=List.length(l) then l else
    let val k = List.nth(l,i) in
        if i = 0 then 
            let val k1 = "<tr><td>"^k^"</td>"
                val l_final = List.update(l,i,k1)
            in create_table(l_final,i+1) end
        else if i = List.length(l)-1 then
            let val k1 = "<td>"^k^"</td></tr>"
                val l_final = List.update(l,i,k1)
            in create_table(l_final,i+1) end
        else 

            let val k1 = "<td>"^k^"</td>"
                val l_final = List.update(l,i,k1)
            in create_table(l_final,i+1) end                         
    end

fun tables(nested_list,i,flag)=
    if i=List.length(nested_list) andalso flag = 1 then let val l_final = nested_list@[["</table>"]] in l_final end
    else if  i = List.length(nested_list) then nested_list
    else 
        let val l = List.nth(nested_list,i);
            val s = List.nth(l,0)
        in 
            if s=">>\n" andalso flag = 1 then 
                let val l_final = l@["</table>"]
                    val nested_list_final = List.update(nested_list,i,l_final)
                in tables(nested_list_final,i+1,0) end
            else if s= "<<\n" andalso flag =0  then
                let val l_final = ["<table style=margin-left:auto;margin-right:auto;>\n>>"]@tl(l)
                    val nested_list_final = List.update(nested_list,i,l_final)
                in tables(nested_list_final,i+1,1) end           
            else if flag=1 then 
                let val content = List.nth(l,0)
                    val split = String.tokens(fn c=> c = #"|") content
                    val l_final = create_table(split,0)
                    val nested_list_final = List.update(nested_list,i,l_final)
                in tables(nested_list_final,i+1,1) end 
            else tables(nested_list,i+1,flag)
        end          
(* --------------------------------------------------------------------------------------------------------------------------------------- *)
(* --------------------------------------------------------------LINKS-------------------------------------------------------------------- *)
fun between_brackets(bracket1,bracket2,s,i,flag,s_final)=
    if i = String.size(s) then s_final 
    else if String.substring(s,i,1)=bracket1 then between_brackets(bracket1,bracket2,s,i+1,1,s_final)
    else if String.substring(s,i,1)=bracket2 then between_brackets(bracket1,bracket2,s,i+1,0,s_final)
    else if flag = 1 then 
        let val s0 = String.substring(s,i,1)
            val s2 = s_final^s0
        in between_brackets(bracket1,bracket2,s,i+1,1,s2) end
    else between_brackets(bracket1,bracket2,s,i+1,flag,s_final)
fun normal_links(l,i)=
    if i= List.length(l) then l 
    else let val s = List.nth(l,i) in
        if String.isPrefix "[" s andalso String.isSuffix ")" s then
            let val s1 = between_brackets("[","]",s,0,0,"")
                val s2 = between_brackets("(",")",s,0,0,"")
                val s_list = String.tokens(fn c=>c = #" ") s2
            in if List.length(s_list)=1 then 
                    let val s3 = "<a href=\""^s2^"\">"^s1^"</a>"
                        val (l_begin,l_end) = List.splitAt(l,i)
                        val l_final = l_begin@[s3]@tl(l_end)
                    in normal_links(l_final,i+1) end
                else let val s21 = List.nth(s_list,0)
                         val s22 = List.nth(s_list,1)
                         val s3 = "<a href=\""^s21^" title="^s22^">"^s1^"</a>"
                         val (l_begin,l_end) = List.splitAt(l,i)
                         val l_final = l_begin@[s3]@tl(l_end)
                    in normal_links(l_final,i+1) end
            end
        else normal_links(l,i+1) end
fun combine(l,i,l_f,flag,s)=
    if i=List.length(l) then l_f
    else if flag =0 then 
        let val s0 = List.nth(l,i) 
        in if String.isPrefix "[" s0 then combine(l,i+1,l_f,1,s^s0^" ")
            else let val l_fi = l_f@[s0] in combine(l,i+1,l_fi,flag,s) end 
        end
    else 
        let val s0 = List.nth(l,i)
        in if String.isSuffix ")" s0 then 
                let val s_f = s^s0
                    val l_fi = l_f@[s_f] in combine(l,i+1,l_fi,0,s_f) end
            else combine(l,i+1,l_f,flag,s^s0)
        end
fun final_norm(l,i)=
    if i = List.length(l) then l
    else let val s0 = List.nth(l,i) in 
        if String.isSubstring "http://" s0 then 
            let val new_l = combine(l,0,[],0,"")
                val l_final = normal_links(new_l,0) in l_final end
        else final_norm(l,i+1) end

fun automatic_links(l,i)=
    if i= List.length(l) then l
    else let val s = List.nth(l,i) in
        if String.isPrefix "<http://" s then 
            let val s1 = between_brackets("<",">",s,0,0,"")
                val s0 = "<a href=\""^s1^"\">"^s1^"</a>"
                val (l_begin,l_end) = List.splitAt(l,i)
                val l_final = l_begin@[s0]@tl(l_end)
            in automatic_links(l_final,i+1) end
        else automatic_links(l,i+1) end
(* ------------------------------------------------------------------------------------------------------------------------------------- *)
(* -------------------------------------------------------------------MAIN FUNCTIONS---------------------------------------------------- *)
fun helper_2(s)= let val s0 = String.substring(s,0,String.size(s)-1) in s0 end

fun para_list_helper(l,i)=
    if i = List.length(l) then l 
    else let val s0 = List.nth(l,i)
         in if String.isPrefix "   " s0 then
            let val s1 = String.substring(s0,3,String.size(s0)-3)
                val (l0,l1) = List.splitAt(l,i-1)
                val s2 = helper_2(List.nth(l1,0))
                val s3 = s2^" "^s1
                val s4 = List.update(l1,0,s3)
                val s5 = l0@[" "^hd(s4)^" "]@tl(tl(s4))
            in para_list_helper(s5,i) end
            else para_list_helper(l,i+1) end 

fun read_all(f)=
    let val inp = TextIO.openIn f
    fun read_help inp = 
        case TextIO.inputLine inp of 
            SOME line => line :: read_help inp
            | NONE => []
        in read_help inp before TextIO.closeIn inp
        end
fun reader(l)=
    let val p0 = String.tokens(fn c=> c = #" ") l 
    in p0 end
fun break_to_list(l,i,l_final)=
    if i = List.length(l) then l_final
    else let val p0 = List.nth(l,i)
             val p1 = reader(p0)
        in break_to_list(l,i+1,l_final@[p1])
        end
fun main_nested(nested_list)=
    let 
        val n2 = unordered_list(nested_list,0,0)
        val n3 = tables(n2,0,0)
        val n1 = ordered_list(n3,0,0)
    in n1 end
fun main_calls(nested_list,i)=
    if i = List.length(nested_list) then nested_list
    else let 
            (* val l2 = blockquote(List.nth(nested_list,i)) *)
            val l8 = headings(List.nth(nested_list,i),0,"",0,0)
             val l3 = bold(l8,0,0)
             val l10 = automatic_links(l3,0)
             val l9 = final_norm(l10,0)
             val l4 = italics(l9,0,0)
             val l5 = underline(l4,0)
             val l6 = horizontal_rule(l5)
             val l7 = write_to_file(l6,0)
        in main_calls(nested_list,i+1)
    end
fun mdt2html(f)=
    let val v = write_up("filename.html","<html><style>table, th, td {border:1px solid black;}</style><body>\n")
        val v0 = read_all(f)
        val v2 = para_list_helper(v0,0)
        val v1 = break_to_list(v2,0,[])
        val v3 = main_nested(v1)
        val v4=main_calls(v3,0) 
    in write_up("filename.html","</body> </html>") end 

