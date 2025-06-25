#tag Class
Protected Class App
Inherits DesktopApplication
	#tag Method, Flags = &h0
		Function SupportEngineKitCreate(Company As String, Name As String, Email As String, Priority As String, Subject As String, Message As String, Category As String) As Boolean
		  // Init
		  SupportEngineKitError = ""
		  
		  // Prepare the JSON payload
		  Var payload As New Dictionary
		  
		  payload.Value("company") = Company
		  payload.Value("name") = Name
		  payload.Value("user_email") = Email
		  payload.Value("subject") = Subject
		  payload.Value("message") = Message
		  payload.Value("category_id") = Category.ToInteger
		  payload.Value("priority") = Priority
		  ' Optional fields
		  ' payload.Value("custom_fields") = New Dictionary ' Optional, add custom fields if needed
		  
		  // Convert the payload to JSON
		  Var jsonGenerator As New JSONItem(payload)
		  Var jsonPayload As String = jsonGenerator.ToString
		  
		  // Create the connection
		  Var conn As New URLConnection
		  conn.RequestHeader("Content-Type") = "application/json"
		  conn.RequestHeader("Authorization") = "Bearer " + SupportEngineKitToken
		  conn.RequestHeader("Accept") = "application/json"
		  
		  
		  Try
		    conn.SetRequestContent(jsonPayload, "application/json")
		    var URLAPI as string 
		    URLAPI = SupportEngineKitURL + "tickets_create.php"
		    
		    Var response As String = conn.SendSync("POST", urlAPI)
		    
		    ' Parse the response
		    Var jsonResponse As New JSONItem(response)
		    
		    If jsonResponse.HasKey("success") And jsonResponse.Value("success") = True Then
		      Return True
		    Else
		      If jsonResponse.HasKey("error") Then
		        SupportEngineKitError = jsonResponse.Value("error").StringValue
		      End If
		      Return False
		    End If
		    
		  Catch e As RuntimeException
		    SupportEngineKitError = e.Message
		    Return False
		  End Try
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		SupportEngineKitError As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SupportEngineKitToken As String = "YOUR_API_TOKEN"
	#tag EndProperty

	#tag Property, Flags = &h0
		SupportEngineKitURL As String = "https://yourdomain.com/api/"
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="ProcessID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastWindowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RegionCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SupportEngineKitToken"
			Visible=false
			Group="Behavior"
			InitialValue="YOUR_API_TOKEN"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SupportEngineKitURL"
			Visible=false
			Group="Behavior"
			InitialValue="https://yourdomain.com/api/"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SupportEngineKitError"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
