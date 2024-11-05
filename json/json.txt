## JSON Parse Tree

### Upload a scan or typeset a parse tree for 

`
{"x":[1,2],"y":{"size":33,"use":true}}
`

Using the JSON grammar at json.org.  Note that X+ means one or more X's (pick as many as you need) and X* means zero or more.  You don't need to follow through string or number just string(use) or number(33) for example is good.


Element -> object, array, or other
Value -> object, array, string, number, t/f, null
Object -> uses {}, members
    Members -> key-value pairs of string, element
Array -> uses [], elements
Member -> string: element

.                           json
                             | 
                          element
                             |
    ______________________object {}_____________________
   /                                                    \
member "x":[1,2]                            member "y":{"size":33,"use":true}
   /          \                                 /               \
string "x"  element [1,2]                string "y"    element{"size":33,"use":true}
                \                                                   |
             array [1,2]                                object?{"size":33,"use":true}
                /      \                                    /                   \
             element   element                       member "size":33      member "use":true
               |          |                          /           \           /            \
             value      value                string "size"  element 33     string "use" element true
               |          |                                     |                              |
               1          2                                  value 33                      value true
                                                                |                              |
                                                                33                            true

PARSE TREE:
.               JSON
                  |
               ELEMENT
                  |
                OBJECT
                  |
                  |
        __________|__________
       |                     |
       |                     |
       |                     |
     member                member
       |                     |
   ____|_____            ____|____
  |          |          |         |
string    element     string   element
  |          |          |         |
 "x"       array       "y"      object
          ___|___                 |
         |       |           _____|____________
      element element       |                  |
         |       |       member              member
       value   value     ___|___            ___|___
         |       |      |       |          |       | 
         1       2    string  element    string  element
                        |       |          |       |
                      "size"  value      "use"   value
                                |                  |
                                33                True

