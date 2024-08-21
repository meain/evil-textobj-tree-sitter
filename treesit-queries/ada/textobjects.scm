;; Support for high-level text objects selections.
;; For instance:
;;    maf     (v)isually select (a) (f)unction or subprogram
;;    mif     (v)isually select (i)nside a (f)unction or subprogram
;;    mai     (v)isually select (a) (i)f statement (or loop)
;;    mii     (v)isually select (i)nside an (i)f statement (or loop)
;;
;; For navigations using textobjects, check link below:
;; https://docs.helix-editor.com/master/usage.html#navigating-using-tree-sitter-textobjects
;;
;; For Textobject queries explaination, check out link below:
;; https://docs.helix-editor.com/master/guides/textobject.html

(subprogram_body) @function.outer
(subprogram_body (non_empty_declarative_part) @function.inner)
(subprogram_body (handled_sequence_of_statements) @function.inner)
(function_specification) @function.outer
(procedure_specification) @function.outer
(package_declaration) @function.outer
(generic_package_declaration) @function.outer
(package_body) @function.outer
