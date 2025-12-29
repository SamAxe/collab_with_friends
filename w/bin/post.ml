
module type DB = Caqti_lwt.CONNECTION
module T = Caqti_type

type db_post =
  { id            : int
  ; container_id  : int    (* This selects all the items related to a document *)
  ; parent_id     : int    (* This is the root of conversation or keeps track of nesting *)
  ; next_id       : int    (* This sorts siblings *)
  ; content       : string (* The actual content *)
  ; author_id     : string    (* Who is writing the post *)
  ; created_at    : string (* When the post was created *)
  }

let post_codec =
  let encode { id; container_id; parent_id; next_id; content; author_id; created_at } = Ok ( id, container_id, parent_id, next_id, content, author_id, created_at ) in
  let decode ( id, container_id, parent_id, next_id, content, author_id, created_at ) = Ok {id; container_id; parent_id; next_id; content; author_id; created_at } in
  Caqti_type.(custom (t7 int int int int string string string) ~encode ~decode)

module Q = struct
  open Caqti_request.Infix

  let insert =
    let open Caqti_type in
      (t5 int int int string int ->. unit)
      "INSERT INTO items (container_id, parent_id, next_id, content, author_id) VALUES (?,?,?,?,?)"
(*

  let find_by_username =
    let open Caqti_request.Infix in
    (Caqti_type.string ->? user_pwd_codec)
    "SELECT username, password_hash FROM users WHERE username = ? LIMIT 1"

  let update_password =
    let open Caqti_request.Infix in
    (Caqti_type.(t2 string string) ->. Caqti_type.unit)
    "UPDATE users SET password_hash = ? WHERE username = ?"

  let exists =
    let open Caqti_request.Infix in
    (Caqti_type.string ->! Caqti_type.bool)
    "SELECT EXISTS(SELECT 1 FROM users WHERE username = ?)"

*)
  let delete =
    let open Caqti_request.Infix in
    (Caqti_type.int ->. Caqti_type.unit)
    "DELETE FROM items WHERE id = ?"

  let posts =
    let open Caqti_request.Infix in

    (Caqti_type.unit ->* post_codec)
    "SELECT * from items"

end

(* module User = struct *)

  let create  container_id parent_id next_id content author_id (module Db : Caqti_lwt.CONNECTION) =
    Db.exec Q.insert (container_id, parent_id, next_id, content, author_id)

  let delete item_id (module Db : Caqti_lwt.CONNECTION) =
    Db.exec Q.delete (item_id )
(*
  let get_by_username username (module Db : Caqti_lwt.CONNECTION) =
    Db.find_opt Q.find_by_username username

  let change_password (module Db : Caqti_lwt.CONNECTION) ~username ~new_hash =
    Db.exec Q.update_password (new_hash, username)

  let exists (module Db : Caqti_lwt.CONNECTION) username =
    Db.find Q.exists username
(* end *)

let register_user username password (module Db : Caqti_lwt.CONNECTION) =
  let open Lwt.Syntax in

  let* already_exists = exists (module Db : Caqti_lwt.CONNECTION) username in
  match already_exists with
  | Ok true ->
      Lwt.return (Error "Username already taken")
  | Ok false ->
      let hash = Result.get_ok (Pwd.hash_password password) in
      let*r = create (module Db : Caqti_lwt.CONNECTION) ~username ~password_hash:hash in
      Lwt.return (Result.map_error Caqti_error.show r)
  | Error e ->
      Lwt.return (Error (Caqti_error.show e))
*)

let get_posts (module Db : Caqti_lwt.CONNECTION) =
  Db.collect_list Q.posts ()
