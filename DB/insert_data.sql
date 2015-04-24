INSERT INTO `Person` (`userId`, `username`, `password`, `auth`) VALUES
(2, 'tom', '123456abc', b'00'),
(3, 'jack', '123456abc', b'00'),
(4, 'mike', '123456abc', b'00'),
(5, 'dan', '123456abc', b'00'),
(6, 'lilei', '123456abc', b'00');

INSERT INTO `Location` (`locationId`, `name`, `state`, `country`, `placeIntro`, `addTime`) VALUES
(1, 'Northeastern University', 'MA', 'USA', 'My School', '2015-03-29 08:00:29'),
(2, 'Museum of Fine Arts', 'MA', 'USA', 'Boston''s oldest, largest and best-known art institution, the MFA houses one of the world''s most comprehensive art collections and is renowned for its Impressionist paintings, Asian and Egyptian collections and early American art.', '2015-03-30 02:12:56'),
(3, 'Fenway Park', 'MA', 'USA', 'Hallowed ground to baseball purists, this cozy, quirky park has been the Boston Red Sox home field since 1912. The most distinctive feature of this classic baseball park is the 37-foot-tall left field wall, known as the "Green Monster."', '2015-03-30 02:14:31'),
(4, 'Freedom Trail', 'MA', 'USA', 'The red line on the sidewalk leads you on this 2.5-mile, self-guided tour of Revolutionary sites, which starts at the Boston Common, America''s oldest public park, and ends up at the famed Bunker Hill Monument.', '2015-03-30 02:15:10'),
(5, 'Boston Public Garden', 'MA', 'USA', 'This Frederick Law Olmsted-designed park, famous for its Swan Boats, has over 600 varieties of trees and an ever-changing array of flowers. It is America''s first public garden.', '2015-03-30 02:15:44'),
(6, 'North End', 'MA', 'USA', 'This Italian neighborhood, Boston''s oldest, is known for its wonderful restaurants and historic sights. Walk the cobblestone streets to take in the architecture and aromas of delicious food, and visit Paul Revere''s house and the Old North Church while you''re in the neighborhood.', '2015-03-30 02:16:16'),
(7, 'Boston Public Library', 'MA', 'USA', 'On the National Register of Historic Places, the library opened in 1852 as the first free, publicly-supported municipal library in America.\r\nThis is a great place.', '2015-03-30 02:17:05'),
(8, 'Boston Tea Party Ships & Museum', 'MA', 'USA', 'At the Boston Tea Party Ships and Museum, you can be a part of the famous event that forever changed the course of American History! Itâ??s more than a stroll through historic artifacts â?? itâ??s an adventure! Located on the Congress Street Bridge in Boston, Massachusetts, this floating museum is unlike anything youâ??ve ever experienced before. Live actors, high-tech, interactive exhibits, authentically restored tea ships and the stirring, multi-sensory documentary â??Let it Begin Here,â?? are just a taste of what youâ??ll see, hear and feel. Meet the colonists, explore the ships and dump tea overboard just as the Sons of Liberty did on that fateful night of December 16, 1773. Stop in at Abigailâ??s Tea Room for teatime and visit the Gift Shop for special souvenirs. Itâ??s educational, entertaining and enlightening â?? an experience not to be missed by adults and children of all ages. Your tour of the Boston Tea Party Ships and Museum will last approximately one hour and will take you through a variety of displays that are interconnected. The tour is designed to give you the opportunity to participate, explore and learn about the people, events and consequences that led up to the American Revolution in the order in which they actually occurred more than 230 years ago.', '2015-04-23 05:38:19'),
(9, 'New England Holocaust Memorial', 'MA', 'USA', 'Relive the Kennedy era in this dynamic combination museum and library, where your visit starts with a short film and then leaves you on your own to explore a series of fascinating exhibits, including the Kennedy-Nixon debate, the Cuban Missile Crisis, the space program, 1960s campaign paraphernalia and displays about Jacqueline and other Kennedy family members. The striking, I.M. Pei-designed building overlooks the water and the Boston skyline.', '2015-04-23 01:45:24');

INSERT INTO `Post` (`postId`, `userId`, `content`, `addTime`) VALUES
(1, 2, 'The museum is huge and there is so much to see. I wish that I would have had some more time to spend there. Make sure to plan enough time to see all the different sections.', '2015-04-23 01:50:33'),
(2, 2, 'Going to the park is the best place to go with the family in Boston. It is fun and exciting for the family. It is a great experience for the children. They will remember this for many years to come. Make sure you record the experience because it will last a lifetime.', '2015-04-23 01:51:29'),
(3, 3, 'Both the accommodation and the proprietors far exceeded our expectations. From fresh pots of tea and biscuits volunteered on arrival late afternoon, through wonderful breakfasts, to an impromptu ''birthday cake'' - complete with candle - for a member of our party - it just got better and better and all complemented by super-king sized comfy beds and luxurious bathrooms.', '2015-04-23 01:56:03'),
(4, 2, 'What a surprise to see such a beautiful library in the city of Boston. I had been there three times but only now did I go in. Don''t ever leave the city without going there (as I erroneously did). Takes a short while but you''ll be amazed.', '2015-04-23 01:57:07'),
(5, 3, 'Old campus with uninspiring architecture, but very pretty in springtime', '2015-04-23 01:58:04'),
(6, 2, 'Staying a week in the North End gave us plenty of opportunities to walk the Freedom Trail and take our time doing it. A stay in the North End means you can walk to nearly all of Boston''s historical sites and attractions.\r\nWe walked to Bunker Hill and to the Tea Party Museum along with all the Freedom Trail sites near our rental.\r\nOur rental, by the way, was the Skinny House which is directly across from the Copp''s Hill Burial Ground on the Freedom Trail. It was an amazing location and we all loved staying there!\r\nWe walked to the North End shops and shopped for our meals. So many delicious bakeries and a great grocery store called Going Bananas.\r\n\r\nVisited March 2015', '2015-04-23 01:58:21'),
(7, 3, 'The outdoor memorial takes just 15 minutes to cover from beginning to end. It does an excellent job of of enabling you to relate to and feel snippets of survivor experiences of the horrors pf the Holocaust.', '2015-04-23 01:59:55'),
(8, 2, 'We walked part of the freedom trail with our family. It was interesting to see some of the sites from our early history. The buildings themselves are less interesting than the story of what happened there. We did not do the whole trail, however, so maybe it is more enjoyable when you visit Bunker Hill, etc. In addition to the historic aspects, it was a nice way to take a walk through Boston.\r\n\r\nVisited April 2015', '2015-04-23 02:00:48'),
(9, 4, 'After reading so many comments about the Freedom Trail, we couldn''t wait to get to Boston and explore it ourselves. It didn''t disappoint, although travelers who are not too knowledgeable about the history behind the American War of Independence might want read up on it or join a guided group when visiting. Wear comfortable shoes as the well-marked trail, beginning at the Boston Common, is almost 3 miles long, with numerous stops along the way. You will find the app ''Freedom Trail'' (a free download to your Android device) very helpful. Amazingly, the app maintains a constant Wi-Fi connection throughout the route (thanks Boston!), informing you about each stop and showing you exactly where you are on the route at any given time ... Excellent! A stop at Bunker Hill and the museum there is well worth the extra effort (both are free).\r\n\r\nVisited April 2015', '2015-04-23 02:01:41'),
(10, 3, 'We stumbled upon a stray brochure for this museum experience. What a gem! We loved it! They keep you moving through the ship, starting with a town meeting. Some individuals even get speaking parts. Part of the fun is learning some colonial expletives and then using them during the tour. ', '2015-04-23 02:01:41'),
(11, 4, 'My friends and I took a morning walk in this park while visiting Boston and it was such beautiful park. The flowers was in full bloom and there were swan boats around the lake in this park that you can take. A lot of people came here for the morning walk or reading books. The park is free but if you park in the garage structure, it''s quite expensive so if you''re gonna stroll the park for a couple hours, look for street parking I guess.\r\n', '2015-04-23 02:03:44'),
(12, 6, 'The people who work at the Tea Party Ships and Museum are what make this attraction one of the best experiences we had with our grandson in Boston. It was more than I expected and I highly recommend it!', '2015-04-23 02:03:47'),
(13, 4, 'It was snowing the day we went. Standing on the deck of the ship throwing the tea overboard seemed real with the horizontal driving snow!! It was a great experience. The tea shop afterwards with free refills was great, the tea was lovely.\r\nThe staff really seemed to enjoy their work and made learning history fun. Fully recommend for all the family.\r\n\r\nVisited March 2015', '2015-04-23 02:04:35'),
(14, 6, 'Our family was visiting Faneuil Hall and the North End and on our travels stumbled upon this memorial. Walking through and seeing the names of the camps with all of the dead on the glass towers was a solemn experience for our family. I had to keep my sunglasses on to hide the tears pouring out of my eyes. It is a stark reminder of modern history that is a must see.', '2015-04-23 02:04:55'),
(15, 4, 'I love NEU!', '2015-04-23 02:11:27'),
(16, 4, 'Beautiful place.', '2015-04-23 02:11:43'),
(17, 4, 'awesome', '2015-04-23 02:11:56'),
(18, 6, 'good', '2015-04-23 02:12:19'),
(19, 6, 'I love this place too.', '2015-04-23 02:12:31');

INSERT INTO `Note` (`postId`, `locationId`, `score`, `title`) VALUES
(1, 2, 10, 'Simply wonderful'),
(2, 3, 9, 'Awesome time'),
(3, 6, 10, 'A great fun'),
(4, 7, 6, 'Just walk in and enjoy'),
(5, 1, 9, 'Northeastern University...if you are in the area'),
(6, 6, 10, 'It was like a trip to Italy!'),
(7, 9, 8, 'A must visit on a Boston Freedpm Trail tour'),
(8, 4, 7, 'Interesting walk'),
(9, 4, 8, 'The Freedom Trail - An Enlightening Adventure'),
(10, 8, 9, 'Best Tea Party'),
(11, 5, 8, 'Beautiful park for a morning walk!'),
(12, 1, 8, 'A must for all!'),
(13, 8, 8, 'Informative interesting & fun'),
(14, 9, 9, 'New England Holocaust Memorial');

INSERT INTO `Comment` (`postId`, `relatedNoteId`) VALUES
(16, 1),
(15, 5),
(17, 7),
(19, 11),
(18, 13);

INSERT INTO `Follow` (`userId1`, `userId2`) VALUES
(2, 1),
(2, 2),
(3, 2),
(4, 2),
(2, 3),
(6, 3),
(2, 4),
(5, 4),
(2, 5),
(3, 5),
(4, 5),
(2, 6),
(3, 6);

INSERT INTO `Like` (`locationId`, `userId`) VALUES
(2, 1),
(2, 2),
(3, 2),
(2, 3),
(1, 4),
(2, 4),
(4, 4),
(8, 4),
(9, 4),
(2, 5),
(2, 6),
(6, 6),
(7, 6),
(9, 6);