module MainSelectImg exposing (main)

-- IMPORT MODULES

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


urlPrefix = "https://cdn.pixabay.com/photo"

view model = 
    div [ class "content" ]
        [ h1 [] [ text "Photo" ]
            , div [ id "thumbnails" ] 
                (List.map                    
                    (viewURL model.selectURL)
                    model.photos
                )
            , img                            
                [ class "large"
                , style "width" "150px" 
                , style "height" "150px"
                , src (urlPrefix ++ model.selectURL)                
                ]
            
            []
        ]

viewURL selectURL thumb = 
    img
    [ src (urlPrefix ++ thumb.url)
    , classList [ ("selected", selectURL == thumb.url)]
    , onClick { description = "ClickedPhoto", data = thumb.url}
    ]
    []


initialModel = 
    { photos =
        [ { url = "/2020/02/25/09/57/road-4878453_960_720.jpg" }
        , { url = "/2022/04/20/06/28/flowers-7144467_960_720.jpg" }
        , { url = "/2022/04/23/20/51/nature-7152461_960_720.jpg" }  
        ]
    , selectURL = "/2020/02/25/09/57/road-4878453_960_720.jpg"
    }


update msg model =
    if msg.description == "ClickedPhoto" then
        { model | selectURL = msg.data }    
    else
        model

main =
    Browser.sandbox 
    { init = initialModel
    , view = view
    , update = update
    }


