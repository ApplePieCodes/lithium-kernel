use limine::BaseRevision;
use limine::framebuffer::Framebuffer;
use limine::request::{FramebufferRequest, RequestsEndMarker, RequestsStartMarker};
use crate::kmain;

#[unsafe(link_section = ".requests")]
static BASE_REVISION: BaseRevision = BaseRevision::new();

static FRAMEBUFFER: FramebufferRequest = FramebufferRequest::new();

#[used]
#[unsafe(link_section = ".requests_start_marker")]
static _START_MARKER: RequestsStartMarker = RequestsStartMarker::new();
#[used]
#[unsafe(link_section = ".requests_end_marker")]
static _END_MARKER: RequestsEndMarker = RequestsEndMarker::new();

#[unsafe(no_mangle)]
pub extern "C" fn init() {
    assert!(BASE_REVISION.is_supported());
    
}
