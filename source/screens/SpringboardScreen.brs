function ShowSpringboardScreen( episodes, selectedEpisode )
	screen = CreateObject( "roSpringboardScreen" )
	screen.SetMessagePort( CreateObject( "roMessagePort" ) )

	'screen.setAdURL( sdAd, hdAd )
	'screen.setAdSelectable( false )

	screen.SetStaticRatingEnabled( false )
	SpringBoardScreen_showContent( screen, episodes[selectedEpisode] )

	while true
		msg = wait( 0, screen.GetMessagePort() )
		if msg <> invalid
			if msg.isScreenClosed()
				exit while
			else if msg.isButtonPressed()
				if msg.GetIndex() = 1
					PlayStart = RegRead( episodes[selectedEpisode].title )
					if PlayStart <> invalid then
						episodes[selectedEpisode].PlayStart = PlayStart.ToInt()
					end if
					ShowVideoScreen( episodes[selectedEpisode] )
					SpringBoardScreen_setButtons( screen, episodes[selectedEpisode] )
					screen.Show()
				end if
				if msg.GetIndex() = 2
					episodes[selectedEpisode].PlayStart = 0
					ShowVideoScreen( episodes[selectedEpisode] )
					SpringBoardScreen_setButtons( screen, episodes[selectedEpisode] )
					screen.Show()
				end if
			else if msg.isRemoteKeyPressed()
				if msg.GetIndex() = 4 ' LEFT
					if selectedEpisode = 0
						selectedEpisode = episodes.Count() - 1
					else
						selectedEpisode = selectedEpisode - 1
					end if
					SpringBoardScreen_showContent( screen, episodes[selectedEpisode] )
				else if msg.GetIndex() = 5 ' RIGHT
					if selectedEpisode = episodes.Count() - 1
						selectedEpisode = 0
					else
						selectedEpisode = selectedEpisode + 1
					end if
                    SpringBoardScreen_showContent( screen, episodes[selectedEpisode] )
				end if
			end if
		end if
	end while
	return selectedEpisode
end function

sub SpringBoardScreen_showContent( screen, episode )
    SpringBoardScreen_setButtons( screen, episode )
    screen.Show()

    SpringBoardScreen_swapPoster( episode )
    screen.SetContent( episode )
    screen.Show()
    SpringBoardScreen_swapPoster( episode )
end sub

sub SpringBoardScreen_swapPoster( show )
	tmp = show.sdPosterURL
	if show.sdPosterURL_hq <> invalid and show.sdPosterURL_hq <> ""
		show.sdPosterURL = show.sdPosterURL_hq
		show.sdPosterURL_hq = tmp
	end if
	tmp = show.hdPosterURL
	if show.hdPosterURL_hq <> invalid and show.hdPosterURL_hq <> ""
		show.hdPosterURL = show.hdPosterURL_hq
		show.hdPosterURL_hq = tmp
	end if
end sub

sub SpringBoardScreen_setButtons( screen, episode )
	screen.ClearButtons()
	if RegRead( episode.title ) <> invalid and RegRead( episode.title ).toint() >=30 then
		screen.AddButton( 1, "Resume Playing" )    
		screen.AddButton( 2, "Play from Beginning" )    
	else
		screen.addbutton( 2,"Play" )
	end if
end sub
