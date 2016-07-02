$(document).ready(function(){
  $('#won_auction').hide();
  $('#lost_auction').hide();
  $('#open_auction').show();


  // function hideTables(table1, table2){
  //   $(table1).hide();
  //   $(tabel2).hide();
  // };
  //
  // function showAuctionTable(buttonID, showTable, table1, table2) {
  //   $(buttonID).on("click", function() {
  //     $(showTable).show();
  //     hideTables(table1, table2);
  //   });
  // };
  //
  // showAuctionTable("#open", "#open_auction", "#won_auction", "lost_auction")
  // showAuctionTable("#won", "#won_auction", "#lost_auction", "open_auction")
  // showAuctionTable("#lost", "#lost_auction", "#open_auction", "won_auction")


  function showOpenAuctions() {
    $("#open").on("click", function(){
      $("#open_auction").show();
      $("#won_auction").hide();
      $("#lost_auction").hide();
    });
  };

  function showLostAuctions() {
    $("#lost").on("click", function(){
      $("#lost_auction").show();
      $("#won_auction").hide();
      $("#open_auction").hide();
    });
  };

  function showWonAuctions() {
    $("#won").on("click", function(){
      $("#won_auction").show();
      $("#lost_auction").hide();
      $("#open_auction").hide();
    });
  };

  showOpenAuctions();
  showLostAuctions();
  showWonAuctions();


});
