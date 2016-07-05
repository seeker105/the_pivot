$(document).ready(function(){
  $('#won_auction').hide();
  $('#lost_auction').hide();
  $('#open_auction').show();

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
