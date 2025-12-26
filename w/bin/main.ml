

let show_form ?message request =
  let open Dream_html in
  let open HTML in
  html []
  [ body []
    [ begin
        match message with
        | None -> p [] [ txt "(blank)" ]
        | Some message ->
            p [] [ txt "You entered: %s" message ]
      end
    ; form [ method_ `POST; action "/"]
      [ csrf_tag request
      ; label [ for_ "msg_id"] [ txt "Message" ]
      ; input [ name "message"; id "msg_id"; autofocus]
      ; input [ type_ "submit"; value "Send" ]
      ]
    ]
  ]
  |> respond


let () =
  Dream.run
    ~port:8081
    ~error_handler:Dream.debug_error_handler
  @@ Dream.logger
  @@ Dream.memory_sessions
  @@ Dream.router
    [ Dream.get  "/" show_form

    ; Dream.post "/"
        (fun request ->
          match%lwt Dream.form request with
          | `Ok ["message", message] -> show_form ~message request
          | _ -> failwith "error"
        )


    ]
