import 'package:build_my_garden/pages/navpages/DetailsPageSpanish.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class DetailsPage extends StatefulWidget {
  int index;

  DetailsPage({Key? key, required this.index}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // String apiKey = "G3aORQyrb17Rg6aFAn9Tlu2SiC-JXISM3UebzBDE6N3-";
  // String ibmUrl =
  //     "https://api.us-south.text-to-speech.watson.cloud.ibm.com/instances/885ec2db-c454-497d-bf9c-813b5c60f619";

  List title = [
    "Sustainable Farming Practices",
    "Homemade Compost from your Kitchen",
    "Boxed Planting for Urban areas",
    "Save your Soil"
  ];
  List info = [
    '''
OK, so sustainable agriculture is the wave of the future. But what is it, exactly?
Sustainability has many facets. Environmental sustainability, for example, means good stewardship of the natural systems and resources that farms rely on. This includes:

• Building healthy soil and preventing erosion
• Managing water wisely
• Minimizing air and water pollution
• Storing carbon on farms
• Increasing resilience to extreme weather
• Promoting biodiversity

An economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.

There’s a whole field of research devoted to achieving these goals: agroecology, the science of managing farms as ecosystems. By working with nature rather than against it, farms can avoid damaging environmental impacts without sacrificing productivity or profitability. And by prioritizing science that addresses the interconnectedness of environmental, economic, and social factors, we can create a truly sustainable system.

Rotating crops and embracing diversity. Planting a variety of crops can have many benefits, including healthier soil and improved pest control. Crop diversity practices include intercropping (growing a mix of crops in the same area) and complex multiyear crop rotations.

Planting cover crops and perennials. Cover crops such as clover, rye, or hairy vetch are planted during off-season times when soils might otherwise be left bare, while perennial crops keep soil covered and maintain living roots in the ground year-round. These crops protect and build soil health by preventing erosion, replenishing soil nutrients, and keeping weeds in check, reducing the need for fertilizers and herbicides.   

Reducing or eliminating tillage. Traditional plowing (tillage) prepares fields for planting and prevents weed problems but can cause soil loss. No-till or reduced-till methods, which involve inserting seeds directly into undisturbed soil, can reduce erosion and improve soil health.

Applying integrated pest management (IPM). A range of methods, including mechanical and biological controls, can be applied systematically to keep pest populations under control while minimizing use of chemical pesticides.

Integrating livestock and crops. Industrial agriculture tends to keep plant and animal production separate, with animals living far from the areas where their feed is produced, and crops growing far away from abundant manure fertilizers. A growing body of evidence shows that a smart integration of crop and animal production can make farms more efficient and profitable.

Adopting agroforestry practices. By mixing trees or shrubs into their operations, farmers can provide shade and shelter that protect plants, animals, and water resources, while also potentially offering additional income from fruit or nut crops.

Managing whole systems and landscapes. Sustainable farms treat uncultivated or less intensively cultivated areas as integral to the farm. For example, natural vegetation alongside streams, or strips of prairie plants within or around crop fields, can help control erosion, reduce nutrient runoff, and support bees and other pollinators and biodiversity in general.

What many of these practices have in common is their focus on soil. Keeping farm soils protected and teeming with living organisms can solve many of the problems associated with industrial agriculture. Healthy, living soil promotes healthy crops, holds water like a sponge, prevents pollution, and helps ensure that farmers and their communities can thrive.




''',
    '''
Composting is putting organic materials in a pile or container and allowing them to decompose into a form that plants can use as nutrients. You need nitrogen, carbon, and water to create compost. Compost or "black gold" has infinite uses in the garden. It's a soil amendment that adds nutrients and improves the texture of almost any garden soil. Blend compost into garden soil before planting for prolific plant growth.
Any gardener can benefit from enriching the soil with nutrients and organic matter to promote plant growth. Compost is one of the most well-liked and useful additions. No matter if you have an indoor or outdoor garden, compost will improve the growth of all of your plants. Compost can be bought at any garden supply store, but making your own is simple and less expensive.
With established perennials, putting a layer of compost every year over the root zone near plant stems functions as both a fertilizer and an amendment to enhance the soil's texture. Additionally, it helps with moisture retention and moderates soil temperature. It lessens or completely replaces the requirement for synthetic fertilizers.
You must consider how you intend to use the compost and how much you require when selecting a compost bin. Do you want a tiny indoor garden or something bigger? Have you have a sizable outdoor area for the pile, or just an apartment.
A trash can be kept in the kitchen. Composters of today are sleek, odorless, and come in sizes that fit even the smallest residences. There are numerous compost bin designs to pick from. A fancier outdoor version, which is just a barrel with a crank that makes it simple to keep the contents mixing, can cost hundreds of dollars. You might also create your own.
Also, instead of a bin, you may want to contain your compost on an outdoor pile for larger amounts. A pile container keeps your pile together. It can be made of any material you have access to, such as:

• Wooden pallets (wire three pallets together and have the fourth side open for turning)
• Lumber
• Cinder blocks
• Plastic or ceramic containers

Three components are required for a good compost pile: green material, brown material, and moisture. Green materials include kitchen trash, coffee grounds, grass trimmings, and pruning waste from new plants. Fallen leaves, shredded tree branches, cardboard, newspaper, hay or straw, and wood shavings are examples of brown materials. You should aim to maintain a ratio of 50% nitrogen-rich green material to 50% inert brown stuff (carbon). Spray just enough water on the pile to dampen it without making it mushy. Microbes may drown if the environment is excessively damp.

Some items should not be used in compost heaps, including:
• Meat and fish
• Dairy, fats, oils
• Woods treated with preservatives
• Diseased, pest-infested plants, or invasive weeds
• Charcoal ash
• Dog and cat waste

Some items will create a smelly pile, attracting rats and other vermin. Take the temperature using a probe deep enough to get about 2/3 of the way down. The ideal temperature is 130 to 140 F. If it gets up to 160 F or more, turn the pile to aerate it to bring the temperature down.

A compost pile can be started any time of the year, although decomposition slows in winter. Plan on turning your pile every two to four weeks using a pitchfork. If you can, take the pile's temperature every day or every time you go to "feed" your pile. Once the pile starts to cool down and the materials turn into a black, crumbly material, then your compost is ready to use in the garden.

Knowing what to do with your compost is necessary now that you have it. Every solution leads to plant food. What changes is how you deliver it.

Feed your lawn, perennials, bulbs, fruit trees, container plants, and trees. Your new or existing plantings can receive a top dressing or a sprinkling.

Instead of applying mulch, cover the soil's surface with a 3- to 6-inch layer of compost. This will stop the soil from losing moisture and keep it moist for longer, while also preventing weed growth.

Potting soil: Combine equal portions of compost, vermiculite, and topsoil to create an enriched potting soil.

Brew a cup of compost tea. A concentrated fertilizer that quickly reaches your plant's roots can be created by creating a liquid emulsion

Also, think about the different methods of composting. You have several options, and all give you the same results, although some ways take longer than others.


Worm composting is best for small-scale, small-batch composting. These composters process household waste in three to six months, producing nutrient-rich worm tea suitable for houseplants and planter boxes. This method doesn't require turning, but you have to balance the conditions so the worms can thrive delicately.

These electric-assist composters, sometimes known as food digesters or food recyclers, aren't truly composters. Your food waste is heated, ground, and transformed in 24 hours into a black, dry fertilizer. Some are the size of beadmakers, while others are comparable to a 13-gallon trash can that is raised. These appliances are efficient but expensive and energy-intensive to operate. Even yet, using these appliances is a much better option than disposing of food leftovers in landfills or incinerators.



''',
    '''
A technique known as "farming in a box" makes use of shipping containers to cultivate agricultural year-round in any setting. Design and technology make it possible for everyone to grow food anywhere thanks to farming in a box.

A method called "farming in a box" makes use of shipping containers to cultivate year-round agricultural in any setting. Through design and technology, farming in a box makes it possible for anybody to grow food anywhere.

A Farm in a Box: What Is It?
A hydroponic system effectively supplies the plants with the nutrients they need by substituting flowing water for soil.

The Leafy Green MachineTM, a mobile and modular farm that can be stacked and transported like shipping containers, was created by Freight Farms. Grow Pod Solutions is another another farm in a box method.

The farm in a box is a vertical hydroponic farming system that is entirely assembled and built within a 40-foot shipping container. In every temperature or region, this technique is effective for growing lettuce, herbs, and greens on a commercial scale. It makes it possible for any person, group, or organization to grow fresh food all year round.

All-weather construction and a stainless interior are features of the farm in a box container. The container is 40' x 8' x 9.6' in dimension. For ideal growth conditions, it offers automated dosing with programmed nutrient & pH dosing. A stainless worktop has a seedling growing stage built right into it. Contrary to conventional farming, it is possible to plant and harvest while standing.

Hundreds of irrigated vertical towers hold thousands of growth patches. With the use of an overhead track system, these towers are easily mobile. In the seedling and mature growth regions, red and blue LED illumination is used to promote leafy development by utilizing only the ideal light wavelengths needed for photosynthesis. The vivid red and blue tones of the LED lights resemble sunshine. To replicate day and night for the plants, the lights turn on and off automatically. For optimum plant development, the day/night cycle and light spectrum must be just right.

The result may be seen clearly from seed to harvest. Without any surprises, the grower will know exactly what goes in and what comes out.

2 to 4 tons of produce can be grown annually, depending on the crop. The technique only needs ten gallons of water every day, which is 90 percent less water than is utilized in conventional farming methods, and there are 52 harvests per year. The hydroponic closed-loop system sends nutrient-rich water right to the roots of the plants. Real-time information from sensors and on-farm cameras may be used by growers to automate processes. Environmental sensors that keep an eye on the farm's water, temperature, and lighting conditions may be used to control an area remotely at the grower's leisure.

Around 500 large heads or 1,000 mini-heads of lettuce may be grown every week using the farm in a box technology. They consist of Lollo Rosa, Butterhead, Bibb, Red and Green Leaf, Romaine, Summer Crisp, and Oakleaf. 50 to 55 pounds of hearty greens, such Kale, Swiss chard, Mustard greens, Asian greens, and Endive, can also be gathered. Expect to get 35 to 45 pounds of herbs, including basil, cilantro, dill, mint, oregano, thyme, and parsley. Other types of greens could also be planted.

With only a 50' x 10' piece of ground needed, the farm in a box container is small and portable and can be set up in a number of locales. However, keep in mind that most container farms require a completely flat platform to operate well, which can necessitate a concrete pad. Drainage line flow must be taken into account. Of course, it will require both a water source and power. A localized food production system also drastically reduces the effect of food transportation.

Plants can be grown hydroponically by being submerged in a nutrient-rich solution of water. No soil is used in hydroponics. An inert medium, such as perlite, rockwool, clay pellets, peat moss, or vermiculite, is used to support the root system. Hydroponics is based on the idea that the roots of the plant should have direct access to the nutrient solution. In order to deliver the nutrient solution to the plants, there are several methods that may be employed in hydroponics.

The quality and freshness of the products cultivated in the farm in a box container are reliable. Herbicides and insecticides are not necessary because of the closed environment of the container, which keeps undesirable organisms out. 94 percent of crops are of commercial quality thanks to protection from the outside environment.

The farm in a box allows people to grow fresh, healthy, organic food, right in their community. There are communities that do not have easy access to healthy, locally grown foods. Some growers are powering their containers with solar energy. In certain areas where there are power outages, it is recommended that a back-up generator be used.

The number of hungry people in the world exceeds the population of the U.S. Canada and the European Union combined. Some growers might want to use a "repurposed" shipping container, purchased from a transportation company and build their own farm in a box. These containers are not made for farming and this concept should be avoided. It is possible for growers to obtain organic certification, depending on a particular states' regulation.

Each year, 3.1 million children die as a result of poor nutrition, accounting for approximately half of all pediatric fatalities. 66 million primary school-aged children in the developing world—23 million of them in Africa alone—come to school hungry. The answer could be to farm in a box.





''',
    '''
Every five seconds, a soccer field's worth of soil is lost to erosion, and by 2050, it's possible that 90% of the Earth's soils will have deteriorated. What does this mean for people and the environment, and what can we do to get the soil we depend on back into a healthy balance?

An underground worm continuously forages for food by consuming soil particles and expulsion nutrient-rich casts. One of the most significant animals on Earth, according to Charles Darwin, is the earthworm. Planet Earth would essentially be a lifeless rock without soil, which worms are essential for. Why then do most people take the ground we walk on for granted?

Although soil may seem limitless and unbreakable to us, these things are not true. The soil we rely on for agriculture only covers around 7.5% of the earth's surface, and it is very delicate. 95 percent of our food is grown in topsoil, which is depleting 10 times more quickly than it is being restored. The corn belt of America has already lost a significant amount of topsoil, endangering not only local economies but also communities and livelihoods. In actuality, healthy topsoil may be destroyed in a matter of minutes, but it takes thousands of years to generate one inch of it.

A healthy soil is a dynamic, living ecosystem that contains air, water, and life. It is made up of a complex mixture of minerals and organic materials. Just one gram of soil may contain as many as 50,000 different kinds of worms, all of which interact with one another to maintain the productivity and health of their soil home. There are hundreds of distinct varieties of soil depending on the activity of these creatures, the type of rock particles, the amount of organic matter, and the balance of air and water. These include flooded peats, loose sandy soils, and the exquisitely balanced loam that is so well adapted for farming. But because of human activities, the world's soil has already deteriorated by one third.

Soil degradation, where soil loses the physical, chemical, or biological qualities that support life, is a natural process but it is being accelerated by human activity. Pollution kills microbial life in the soil; deforestation and development disturb soil structure making it vulnerable to erosion. Climate change continues to dry the ground, and three-quarters of Spain is at risk of becoming desert.

The need to feed a growing population and drive greater efficiency has sacrificed natural balance for increased yields. Monoculture farming drains the soil of specific nutrients and allows pests, pathogens, and diseases to thrive. Excessive use of pesticides reduces vital biodiversity and speeds up the breakdown of organic matter.

Even the plow, often considered one of history's great inventions, can be bad news for soil. Tilling breaks up compacted ground, controls weeds, and incorporates organic matter. But it also damages soil structure, dries out topsoil, and accelerates erosion.
Soil filters the water we drink, grows the food we eat, and captures the carbon dioxide that causes climate change. Soil is the largest carbon sink after the ocean and holds more carbon than all terrestrial plant life on the planet. When we damage the soil, water systems become disrupted, food production declines, and carbon is released into the atmosphere.

How then can we protect our soils? Changing the way agriculture is done now is necessary for many strategies to lessen and even undo the damage. Soil begins to heal when we stop tilling the ground and use less herbicides and fertilizers. By switching back to crop rotations, we may reduce our reliance on monoculture and give the soil time to restock the nutrients that plants require. Agroforestry might take this a step further by cultivating a range of plants concurrently in a way that fosters the health of the soil and supports each other's biological processes. Similar to this, encouraging soil fungus increases disease resistance, improves soil structure, and aids in plant nutrient uptake. These beneficial techniques have the potential to regenerate our soils, support local economies and communities, and maintain the health of both people and the environment, but they call for significant adjustments.

Knutr, Unilever's largest food brand, has set a goal of growing 80 percent of its key ingredients following Regenerative Agriculture Principles by 2026. Already, Knorr has partnered with Spanish tomato growers to use cover crops to improve soil health and reduce the use of synthetic fertilizers.

Whether it's on an allotment, in a back garden or on a windowsill, growing your own vegetables is the most environmentally friendly way to get your food. Leaving soil bare is not good for its health, so make sure you keep it covered with plants and cover crops.

A good way of saving soil at home is to plant flowers and plants that are beneficial to soil health. Deep-rooting plants stop compaction and promote healthy soil structure, and draw nutrients deeper in for use by other plants. There are plenty of species you can plant in your garden or shared outdoor space.

Our farming practices and eating habits have a huge impact on the health of our soils. By choosing to support organic or agroecological farming in your neighborhood, you are endorsing a practice that relies on enhancing soil fertility organically to feed plants.

Share this information with friends and family, and help them to start saving their own soils at home too. Together, we can use our power as citizens to influence the Government to commit to prioritizing soil health.





'''
  ];

  

  List images = [
    "assets/images/CategoryPageImg/img1.gif",
    "assets/images/CategoryPageImg/img2.gif",
    "assets/images/CategoryPageImg/img3.gif",
    "assets/images/CategoryPageImg/img4.gif"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 90,
              automaticallyImplyLeading: false,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 38, left: 6.4, bottom: 17),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 8, 78, 83),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 38, right: 6.4, bottom: 17),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 8, 78, 83),
                        shape: BoxShape.circle,
                      ),
                      child: ResponsiveButton(
                        text: "Translate",
                        onPress: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPageSpanish(index: widget.index,)));
                          // if (isPlaying) {
                          //   await audioPlayer.pause();
                          // } else {
                          //   String url =
                          //       'https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav';
                          //   await audioPlayer.setSourceUrl(url);
                          // }
                          // audioCache.load('hello_world.wav');
                        },
                        // icon: Icon(Icons.audiotrack_outlined),
                        // color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ]),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Positioned(
                  top: 50,
                  child: Container(
                    child: Center(
                        child: AppText(
                      text: title[widget.index],
                      size: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                    )),
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 8, 78, 83),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(20, 10),
                          topRight: Radius.elliptical(20, 10),
                          bottomLeft: Radius.elliptical(5, 0),
                          bottomRight: Radius.elliptical(5, 0),
                        )),
                  ),
                ),
              ),
              pinned: true,
              backgroundColor: Color.fromARGB(255, 8, 78, 83),
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(images[widget.index],
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    height: double.maxFinite),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                  child: Column(
                children: [
                  Container(
                    child: Center(
                      child: AppText(
                          fontWeight: FontWeight.w500,
                          text: info[widget.index]),
                    ),
                    margin: EdgeInsets.only(left: 40, right: 40, top: 20),
                  ),
                ],
              )),
            ),
          ],
        ));
  }
}
