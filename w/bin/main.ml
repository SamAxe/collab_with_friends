

let show_form ?message request =
  let open Dream_html in
  let open HTML in
  html []
  [ body []
    [ begin
        match message with
        | None -> p [] []
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


let message_form_request_decoder =
  let open Dream_html.Form in
  let+ greeting = required string "message" in
  greeting


let message_form_handler request =
  match%lwt Dream_html.form message_form_request_decoder request with
  | `Ok message -> show_form ~message request
  | _ -> failwith "error"


let () =
  Dream.run
    ~port:8081
    ~error_handler:Dream.debug_error_handler
  @@ Dream.logger
  @@ Dream.memory_sessions
  @@ Dream.router
    [ Dream.get  "/" show_form

    ; Dream.post "/" message_form_handler

    ]
