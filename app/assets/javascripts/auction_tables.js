$(document).ready(function(){
  $('#won_auction').hide();
  $('#lost_auction').hide();
  $('#open_auction').show();

  function showOpenAuctions() {
    $(document).on("click", "#open", function(){
      $("#open_auction").show();
      $("#won_auction").hide();
      $("#lost_auction").hide();
    });
  };

  function showLostAuctions() {
    $(document).on("click", "#lost", function(){
      $("#lost_auction").show();
      $("#won_auction").hide();
      $("#open_auction").hide();
    });
  };

  function showWonAuctions() {
    $(document).on("click", "#won", function(){
      $("#won_auction").show();
      $("#lost_auction").hide();
      $("#open_auction").hide();
    });
  };

  showOpenAuctions();
  showLostAuctions();
  showWonAuctions();
});
