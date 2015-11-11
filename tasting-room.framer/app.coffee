Framer.Device.background.backgroundColor = "purple"
Framer.Device.background.backgroundColor = "#B4DCD8"




myLayers = Framer.Importer.load "imported/2014.9"



Framer.Device.phone.image = ""



myWinesScreen = myLayers.myWinesScreen
shipmentDetails = myLayers.shipmentDetails
nextShipmentScreen = myLayers.nextShipmentScreen
nav = myLayers.nav
menu = myLayers.menu2
nextShipment = myLayers.nextShipment
nextShipmentSelected = myLayers.nextShipmentSelected
more = myLayers.more
myWinesSelected = myLayers.myWinesSelected
xClose = myLayers.xClose
chuteBox = myLayers.chuteBox
tapToRate = myLayers.tapToRateText
iLovedIt = myLayers.iLovedItText
heart = myLayers.heart
unratedNotification = myLayers.unratedAlert2
wineCell = myLayers.wineCellRed
trail = myLayers.trail
daysLeft = myLayers.daysLeft
date = myLayers.April_4th
x = myLayers.x
tracker = myLayers.tracker
deliciousness = myLayers.deliciousness
tracking = myLayers.tracking
contents = myLayers.contents
wine1 = myLayers.wine1
wine2 = myLayers.wine2
blurBG = myLayers.blurBG

x.opacity = 0
trail.opacity = 0
date.opacity = 0
daysLeft.opacity = 0
heart.opacity = 0
iLovedIt.opacity = 0
heart.scale = .6
heart.rotationZ = -90
iLovedIt.y = 17
chuteBox.originY = 0
direction = 1
nextShipmentSelected.opacity = 0
nextShipmentScreen.y = 1136
blurBG.opacity = 0

shipmentArray = [deliciousness, tracking, contents, wine1, wine2]
deliciousness.opacity = 0
tracking.opacity = 0
contents.opacity = 0
wine1.opacity = 0
wine2.opacity = 0
xClose.opacity = 0

scroll = ScrollComponent.wrap(myLayers.shipmentFeed)
scroll.scrollHorizontal = false


exitRatingText = new Animation
	layer: tapToRate
	properties: 
		opacity: 0
		y: 17
	time: .2

enterRatingText = new Animation
	layer: iLovedIt
	properties: 
		opacity: 1
		y: 27
	time: .2
	
enterRatingSymbol = new Animation
	layer: heart
	properties: 
		rotationZ: 0
		scale: 1
		opacity: 1
	time: .1





touchCircle = new Layer
	width: 30
	height: 30
	borderRadius: 40
	backgroundColor: '#CECACA'
	opacity: 0
	
circleExpand = new Animation
	layer: touchCircle
	properties: 
		scale: 6
		opacity: 0
	curve: 'ease-out'
	time: .15

touch = (xPos, yPos) ->
	touchCircle.x = xPos
	touchCircle.y = yPos
	touchCircle.opacity = 1
	circleExpand.start()
	circleExpand.on "end", ->
		touchCircle.scale = 1

swipeDisplaceY = 180








# Swinging the Parachute Box
swingChute = ->
	boxAnimation = chuteBox.animate
		properties: 
			rotationZ: 6 * direction
		time: 2.4
		curve: "bezier-curve"
		curveOptions: "ease-in-out"		
	boxAnimation.on "end", ->
		repeatSwingChute()

repeatSwingChute = ->
	direction *= -1
	swingChute()	

repeatSwingChute()



rateWine = ->
# 	Rate the card
	exitRatingText.start()
		
	exitRatingText.on "end", ->
		enterRatingText.start()
		enterRatingSymbol.start()	
		enterRatingText.on "end", ->
			unratedNotification.animate
				properties: 
					opacity: 0
					scale: 1.2
					spring: "bezier"
				time: .2
			
			Utils.delay .2, ->
				wineCell.animate
					properties: 
						x: 740
						opacity: 0
# 					curve: 'spring(200, 25, 2)'
					time: .4
				



minimizeMyWines = ->
# 	My Wines minimizes
	
	Utils.delay .2, ->
		myWinesScreen.animate
			properties: 
				y: 1031
			curve: 'spring(200, 25, 2)'




openNextShipment = ->
# 	Next Shipment screen enters
	
	nextShipmentSelected.animate 
		properties:
			opacity: 1
		time: .15

	nextShipment.animate 
		properties:
			opacity: 0
		time: .1
		
	myWinesSelected.animate
		properties:
			opacity: 0
		time: .3
	
	myWinesScreen.animate
		properties:
			y: 1136
		time: .1
		curve: 'ease-in'
	
	Utils.delay .2, ->
		nextShipmentScreen.bringToFront()
		nextShipmentScreen.animate
			properties: 
				y: 0
			curve: 'spring(200, 25, 2)'
			
	Utils.delay .3, ->
		date.animate 
			properties: 
				opacity: 1
			time: 1.8
		
		daysLeft.animate 
			properties: 
				opacity: 1
				scale: .95
				curve: 'spring'
			time: .6
			delay: .7
			
		chuteBox.animate 
			properties: 
				y: chuteBox.y + 32
			time: 1
			
		trail.animate 
			properties: 
				opacity: 1
			time: .7




openShipmentDetails = ->
# 	Open Shipment Details
	
	Utils.delay .15, ->
		shipmentDetails.bringToFront()
		
		blurBG.animate
			properties: 
				opacity: 1
			time: .4
		
		i = 0
		for item in shipmentArray
			do (item) ->
				item.opacity = 0
				
				itemEndY = item.y
				item.y -= 15
						
				itemAnimation = new Animation
					layer: item
					properties: 
						opacity:1
						y: itemEndY
					time: .25
					delay: .05 * i
					curve: "ease-out"
					
				itemAnimation.start()
				i++
			
		Utils.delay .3, ->
			xRotationZ = x.rotationZ
			x.rotationZ -= 20
			xCloseEndY = xClose.y
			xClose.y += 30
			xClose.animate
				properties:
					y:	xCloseEndY
					opacity: 1
				time: .2
	
			Utils.delay .2, ->
				x.animate
					properties: 
						rotationZ: xRotationZ
						scale: .9
						opacity: 1
					time: .4
					curve: 'spring(150,0,0)'













# Story Controller
Utils.delay 2, ->
	rateWine()
	
	touch(330, 760)
		
	
	Utils.delay 2, ->
		minimizeMyWines()
		
		touch(570, 60)
	
	
		Utils.delay 1.1, ->
			openNextShipment()
			
			touch(440, 165)	
			
			
			Utils.delay 3.2, ->
				openShipmentDetails()
							
				touch(530, 455)
				
				
				Utils.delay 1.4, ->
					scroll.scrollToPoint
						x: 0, y: 786
						true
						curve: 'ease', time: 1
					
					touch(480, 800)
					touchCircle.animate
						properties:
							y: touchCircle.y - swipeDisplaceY
						time: .3
