open Core.Std

let rec ls_rec s =
  if Sys.is_file_exn ~follow_symlinks:true s
  then [s]
  else
    Sys.ls_dir s
    |> List.concat_map ~f:(fun sub -> ls_rec (s ^/ sub))

let rec print_list = function
    [] -> ()
  | e::l -> print_string e ; print_string "\n" ; print_list l

let result = ls_rec "."
let () = print_list result
