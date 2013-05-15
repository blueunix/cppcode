:# Check the results of the IBM PC version of htmlpty
:# [31-Oct-1997]

del check*.err
del check*.out

htmlpty -l check001.err -n <check001.in >check001.out
diff check001.eok check001.err
diff check001.ok check001.out

htmlpty -l check002.err -n <check002.in >check002.out
diff check002.eok check002.err
diff check002.ok check002.out

htmlpty -l check003.err -n <check003.in >check003.out
diff check003.eok check003.err
diff check003.ok check003.out

htmlpty -l check004.err -n <check004.in >check004.out
diff check004.eok check004.err
diff check004.ok check004.out

htmlpty -l check005.err -n <check005.in >check005.out
diff check005.eok check005.err
diff check005.ok check005.out

htmlpty -l check006.err -n <check006.in >check006.out
diff check006.eok check006.err
diff check006.ok check006.out

htmlpty -l check007.err -n <check007.in >check007.out
diff check007.eok check007.err
diff check007.ok check007.out

htmlpty -l check008.err -n <check008.in >check008.out
diff check008.eok check008.err
diff check008.ok check008.out

htmlpty -l check009.err -n <check009.in >check009.out
diff check009.eok check009.err
diff check009.ok check009.out

htmlpty -l check010.err -n <check010.in >check010.out
diff check010.eok check010.err
diff check010.ok check010.out

htmlpty -l check011.err -n <check011.in >check011.out
diff check011.eok check011.err
diff check011.ok check011.out

htmlpty -l check012.err -n <check012.in >check012.out
diff check012.eok check012.err
diff check012.ok check012.out

htmlpty -l check013.err -n <check013.in >check013.out
diff check013.eok check013.err
diff check013.ok check013.out

htmlpty -l check014.err -n -bri -cat ../Styles/catalog -grammar-level dtd -no-comment-banner <check014.in >check014.out
diff check014.eok check014.err
diff check014.ok check014.out

htmlpty -l check015.err -n -bri -cat ../Styles/catalog -grammar-level dtd -no-comment-banner <check015.in >check015.out
diff check015.eok check015.err
diff check015.ok check015.out

htmlpty -l check016.err -n -stylefile check016.sty <check016.in >check016.out
diff check016.eok check016.err
diff check016.ok check016.out

htmlpty -l check017.err -n <check017.in >check017.out
diff check017.eok check017.err
diff check017.ok check017.out

htmlpty -l check018.err -n <check018.in >check018.out
diff check018.eok check018.err
diff check018.ok check018.out

htmlpty -l check019.err -n <check019.in >check019.out
diff check019.eok check019.err
diff check019.ok check019.out

htmlpty -l check020.err -n -keep-format <check020.in >check020.out
diff check020.eok check020.err
diff check020.ok check020.out

htmlpty -l check021.err -n <check021.in >check021.out
diff check021.eok check021.err
diff check021.ok check021.out

htmlpty -l check022.err -n <check022.in >check022.out
diff check022.eok check022.err
diff check022.ok check022.out

htmlpty -l check023.err -n <check023.in >check023.out
diff check023.eok check023.err
diff check023.ok check023.out

htmlpty -l check024.err -n <check024.in >check024.out
diff check024.eok check024.err
diff check024.ok check024.out

htmlpty -l check025.err -n <check025.in >check025.out
diff check025.eok check025.err
diff check025.ok check025.out

htmlpty -l check026.err -n <check026.in >check026.out
diff check026.eok check026.err
diff check026.ok check026.out

